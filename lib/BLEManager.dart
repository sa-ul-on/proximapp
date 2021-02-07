import 'dart:io';
import 'dart:math';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLEManager {
  static const String uuid = '35ED98FF-2900-441A-802F-9C398FC199D2';
  static const int majorId = 155;
  static const int minorId = 13;
  static const int transmissionPower = -115;
  static const AdvertiseMode advertiseMode = AdvertiseMode.lowPower;
  static const String layout = BeaconBroadcast.ALTBEACON_LAYOUT;
  static const int manufacturerId = 0x0118;
  static const List<int> extraData = [100];

  BeaconBroadcast _beaconBroadcast = BeaconBroadcast();
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  Function(int, double) _callback;

  void setCallback(Function(int, double) callback) {
    this._callback = callback;
  }

  void startBroadcastAndScan(int trackingId) async {
    // Broadcasting
    BeaconStatus beaconStatus =
        await _beaconBroadcast.checkTransmissionSupported();
    if (beaconStatus == BeaconStatus.supported)
      print('Device supports transmitting as a beacon');
    else if (beaconStatus == BeaconStatus.notSupportedMinSdk)
      print('Android system version on the device is too low (min. is 21)');
    else if (beaconStatus == BeaconStatus.notSupportedBle)
      print('Device doesn\'t support Bluetooth Low Energy');
    else if (beaconStatus == BeaconStatus.notSupportedCannotGetAdvertiser)
      print('Device\'s Bluetooth chipset/driver not supporting transmitting');
    _beaconBroadcast.getAdvertisingStateChange().listen((isAdvertising) {
      print('advertising state changed in ' + isAdvertising.toString());
    });
    if (Platform.isIOS) {
      await _beaconBroadcast
          .setUUID(uuid)
          .setMajorId(majorId)
          .setMinorId(minorId)
          .setIdentifier(trackingId.toString())
          .setLayout(
              'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24') // solo per iOS
          .setManufacturerId(0x004c) // solo per iOS
          .setTransmissionPower(transmissionPower)
          .start();
    } else {
      await _beaconBroadcast
          .setUUID(uuid)
          .setMajorId(majorId)
          .setMinorId(minorId)
          .setIdentifier(trackingId.toString())
          .setTransmissionPower(transmissionPower)
          .start();
    }
    // Scanning
    _flutterBlue.startScan();
    bool isListenerAlreadySet = await _flutterBlue.scanResults.isEmpty;
    if (isListenerAlreadySet) {
      _flutterBlue.scanResults.listen((List<ScanResult> results) {
        int nDevices = results.length;
        print('Numero di dispotivi nelle vicinanze $nDevices');
        for (ScanResult r in results) {
          double distance = pow(10, (transmissionPower - r.rssi) / (10 * 2));
          // da testare una funzione più accurata per calcolare la distanza
          print('Ho trovato un dispositivo con:');
          print(r.advertisementData);
          // valori null sui dispositivi che stiamo simulando, quando si monitora un vero beacon saranno settati con eg:  .setTransmissionPower(transmissionPower)
          //print("Nome:" +r.advertisementData.localName);
          //print("UUID": r.advertisementData.serviceUuids.first);
          // TODO
          /*
        r.device.id;
        r.device.id.id;
        r.advertisementData.serviceUuids;
        r.advertisementData.localName;
        r.advertisementData.serviceData;*/
          int txPower = r.advertisementData.txPowerLevel;
          int rssi = r.rssi;
          print('TxLevel: $txPower');
          print('Rssi: $rssi');
          if (distance < 5) {
            if (_callback != null) {
              _callback(int.parse(r.device.id.toString()), distance);
            }
          }
        }
      });
    } else {
      print('Allora esiste un caso in cui...');
    }
  }

  void stopBroadcastAndScan() async {
    await _beaconBroadcast.stop();
    await _flutterBlue.stopScan();
  }
}
