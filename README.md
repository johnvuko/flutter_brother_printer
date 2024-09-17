[![Pub Likes](https://img.shields.io/pub/likes/brother_printer)](https://pub.dev/packages/brother_printer)
[![Pub Popularity](https://img.shields.io/pub/popularity/brother_printer)](https://pub.dev/packages/brother_printer)
[![Pub Points](https://img.shields.io/pub/points/brother_printer)](https://pub.dev/packages/brother_printer)

# brother_printer

Brother printer SDK for Flutter using native SDK v4.

## Installation

Be sure to read requirements of the native SDK:
https://support.brother.com/g/s/es/htmldoc/mobilesdk/

Add this to your package's pubspec.yaml file:

```
dependencies:
  brother_printer: ^0.2.0
```

### iOS

In the `Podfile` uncomment:

```
    platform :ios, '13.0'
```

In the `Info.plist` add:

```
    <key>NSBluetoothAlwaysUsageDescription</key>
    <string>Bluetooth is required for connection to your printer.</string>
    <key>NSBluetoothPeripheralUsageDescription</key>
    <string>Bluetooth is required for connection to your printer.</string>
    <key>NSLocalNetworkUsageDescription</key>
    <string>${PRODUCT_NAME} uses the local network to discover printers on your network.</string>
    <key>UISupportedExternalAccessoryProtocols</key>
    <array>
        <string>com.brother.ptcbp</string>
    </array>
    <key>NSBonjourServices</key>
    <array>
        <string>_printer._tcp</string>
        <string>_pdl-datastream._tcp</string>
        <string>_ipp._tcp</string>
    </array>
```

### Android

Connection doesn't seem to work on emulator.

Add permissions:

```
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />

    <uses-permission
        android:name="android.permission.BLUETOOTH_SCAN"
        android:usesPermissionFlags="neverForLocation"
        tools:targetApi="s" />

    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

You have to manually authorized the location permission on the device (will be improve later).

#### Warning

You may have some crash in release mode, you can add this to your `android/app/build.gradle`:

```
    buildTypes {
        release {
            minifyEnabled false
            shrinkResources false

            signingConfig signingConfigs.release
        }
    }
```


## Notes

There are difference between what return the iOS version and the Android version

```
    print('${device.model.nameAndroid} - ${device.source} - ${device.modelName} - ${device.ipAddress} - ${device.printerName} - ${device.macAddress} - ${device.nodeName} - ${device.serialNumber} - ${device.bleAdvertiseLocalName}');

    # iOS
    QL-820NWB - BrotherDeviceSource.network - Brother QL-820NWB - 10.0.0.1 - Brother QL-820NWB - b0:68:e6:97:db:42 - BRWB068E697DB42 - K9Z195606 - null
    QL-820NWB - BrotherDeviceSource.bluetooth - QL-820NWB - null - QL-820NWB5606 - null - null - 806FB0BABE7C - null

    Network: modelName, ipAddress, printerName, network macAddress, nodeName, serialNumber
    Bluetooth: modelName, printerName, serialNumber

    # Android
    QL-820NWB - BrotherDeviceSource.network - Brother QL-820NWB - 10.0.0.1 - null - B0:68:E6:97:DB:42 - BRWB068E697DB42 - null - null
    QL-820NWB - BrotherDeviceSource.bluetooth - null - null - QL-820NWB5606 - 80:6F:B0:BA:BE:7D - null - null - null

    Network: modelName, ipAddress, network macAddress, serialNumber
    Bluetooth: printerName, bluetooth macAddress
```

## Author

- [Jonathan VUKOVICH](https://github.com/johnvuko)

