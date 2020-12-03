import 'dart:io';

import 'package:beacon_broadcast/beacon_broadcast.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLEManager {
  static const String uuid = '35ED98FF-2900-441A-802F-9C398FC199D2';
  static const int majorId = 155;
  static const int minorId = 1033;
  static const int transmissionPower = -115;
  static const String identifier = 'com.example.myDeviceRegion';
  static const AdvertiseMode advertiseMode = AdvertiseMode.lowPower;
  static const String layout = BeaconBroadcast.ALTBEACON_LAYOUT;
  static const int manufacturerId = 0x0118;
  static const List<int> extraData = [100];

  BeaconBroadcast beaconBroadcast = BeaconBroadcast();
  FlutterBlue flutterBlue;

  void init() async {
    BeaconStatus beaconStatus =
        await beaconBroadcast.checkTransmissionSupported();
    if (beaconStatus == BeaconStatus.SUPPORTED)
      print('Device supports transmitting as a beacon');
    else if (beaconStatus == BeaconStatus.NOT_SUPPORTED_MIN_SDK)
      print('Android system version on the device is too low (min. is 21)');
    else if (beaconStatus == BeaconStatus.NOT_SUPPORTED_BLE)
      print('Device doesn\'t support Bluetooth Low Energy');
    else if (beaconStatus == BeaconStatus.NOT_SUPPORTED_CANNOT_GET_ADVERTISER)
      print('Device\'s Bluetooth chipset/driver not supporting transmitting');
    beaconBroadcast.getAdvertisingStateChange().listen((isAdvertising) {
      print('advertising state chaged in ' + isAdvertising.toString());
    });
    if (Platform.isIOS) {
      await beaconBroadcast
          .setUUID(uuid)
          .setMajorId(majorId)
          .setMinorId(minorId)
          .setLayout(
              'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24') // solo per iOS
          .setManufacturerId(0x004c) // solo per iOS
          .start();
      print("ios detected");
    } else {
      await beaconBroadcast
          .setUUID(uuid)
          .setMajorId(majorId)
          .setMinorId(minorId)
          .setTransmissionPower(transmissionPower)
          .start();
      print("android detected");
      flutterBlue = FlutterBlue.instance;
    }
    print(beaconBroadcast.isAdvertising());
    print(beaconBroadcast);
  }

  Stream<BluetoothState> getBLE() {
    return FlutterBlue.instance.state;
  }

  dynamic lookAround() {
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      int nDevices = results.length;
      print("Numero di dispotivi nelle vicinanze $nDevices");
      for (ScanResult r in results) {
        // double tx = -115;
        // double distance = pow(10, (tx - r.rssi) / (10 * 2));
        // da testare una funzione più accurata per calcolare la distanza
        print("Ho trovato un dispositivo con:");
        print(r.advertisementData);
        // valori null sui dispositivi che stiamo simulando, quando si monitora un vero beacon saranno settati con eg:  .setTransmissionPower(transmissionPower)
        //print("Nome:" +r.advertisementData.localName);
        //print("UUID": r.advertisementData.serviceUuids.first);
        int txPower = r.advertisementData.txPowerLevel;
        int rssi = r.rssi;
        print("TxLevel: $txPower");
        print("Rssi: $rssi");

        if (r.rssi > -50) {
          print("Sei troppo vicino al dispositivo ");
          //print(r.advertisementData.localName); null
        }
      }
    });
  }
}
