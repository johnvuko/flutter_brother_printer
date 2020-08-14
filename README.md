# brother_printer

A new flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

## Installation

https://support.brother.com/g/s/es/htmldoc/mobilesdk/

### iOS

In the `Podfile` uncomment:

```
    platform :ios, '9.0'
```

In the `Info.plist` add:

```
	<key>NSBluetoothAlwaysUsageDescription</key>
	<string>Bluetooth is required for connection to printers.</string>
```

### Android

Connection doesn't seem to work on emulator.

Add permissions:

```
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

You have to manually authorized the location permission on the device (will be improve later)
