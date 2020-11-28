import 'dart:io';

import 'package:beacon_broadcast/beacon_broadcast.dart';

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

  void init() {
    beaconBroadcast.checkTransmissionSupported().then((beaconStatus) {
      if (beaconStatus == BeaconStatus.SUPPORTED)
        print('Device supports transmitting as a beacon');
      else if (beaconStatus == BeaconStatus.NOT_SUPPORTED_MIN_SDK)
        print('Android system version on the device is too low (min. is 21)');
      else if (beaconStatus == BeaconStatus.NOT_SUPPORTED_BLE)
        print('Device doesn\'t support Bluetooth Low Energy');
      else if (beaconStatus == BeaconStatus.NOT_SUPPORTED_CANNOT_GET_ADVERTISER)
        print('Device\'s Bluetooth chipset/driver not supporting transmitting');
    });
    beaconBroadcast.getAdvertisingStateChange().listen((isAdvertising) {
      print('advertising state chaged in ' + isAdvertising.toString());
    });
    if (Platform.isIOS) {
      beaconBroadcast
          .setUUID(uuid)
          .setMajorId(majorId)
          .setMinorId(minorId)
          .setLayout(
              'm:2-3=0215,i:4-19,i:20-21,i:22-23,p:24-24') // solo per iOS
          .setManufacturerId(0x004c) // solo per iOS
          .start();
      print("ios detected");
    } else {
      beaconBroadcast
          .setUUID(uuid)
          .setMajorId(majorId)
          .setMinorId(minorId)
          .setTransmissionPower(transmissionPower)
          .start();
      print("android detected");
    }
    print(beaconBroadcast);
  }
}
