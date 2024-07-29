import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';
import 'model.dart';

enum BrotherDeviceSource {
  network,
  bluetooth,
  ble,
  usb,
}

extension on BrotherDeviceSource {
  String toJsonString() {
    switch (this) {
      case BrotherDeviceSource.network:
        return 'network';
      case BrotherDeviceSource.bluetooth:
        return 'bluetooth';
      case BrotherDeviceSource.ble:
        return 'ble';
      case BrotherDeviceSource.usb:
        return 'usb';
    }
  }
}

class BrotherDevice extends Equatable {
  final String? ipAddress;
  final String? location;
  final String modelName;
  final String? printerName;
  final String? serialNumber;
  final String? nodeName;
  final String? macAddress;
  final String? bleAdvertiseLocalName;
  final BrotherDeviceSource source;
  final BrotherModel model;

  /// For iOS must set at least `ipAddress` or `serialNumber`or `bleAdvertiseLocalName`
  /// For Android must set at least `ipAddress` or `macAddress` or `bleAdvertiseLocalName` or it should be connected in USB
  const BrotherDevice({
    required this.source,
    required this.model,
    required this.modelName,
    this.ipAddress,
    this.location,
    this.printerName,
    this.serialNumber,
    this.nodeName,
    this.macAddress,
    this.bleAdvertiseLocalName,
  });

  static BrotherDevice? fromJson(Map<String, String?> json) {
    if ((json['modelName'] == null && json['printerName'] == null && json['bleAdvertiseLocalName'] == null) || json['source'] == null) {
      return null;
    }

    final modelFound = _findModel(
      json['modelName'],
      json['printerName'],
      json['bleAdvertiseLocalName'],
    );

    if (modelFound == null) {
      return null;
    }

    final sourceFound = _findSource(json['source']!);

    if (sourceFound == null) {
      return null;
    }

    return BrotherDevice(
      model: modelFound,
      ipAddress: json['ipAddress'],
      location: json['location'],
      modelName: json['modelName'] ?? modelFound.nameAndroid,
      printerName: json['printerName'],
      serialNumber: json['serialNumber'],
      nodeName: json['nodeName'],
      macAddress: json['macAddress'],
      bleAdvertiseLocalName: json['bleAdvertiseLocalName'],
      source: sourceFound,
    );
  }

  BrotherDevice.fromNetwork(this.model, this.ipAddress)
      : source = BrotherDeviceSource.network,
        modelName = model.nameAndroid,
        location = null,
        printerName = null,
        serialNumber = null,
        nodeName = null,
        macAddress = null,
        bleAdvertiseLocalName = null;

  /// USB devices doesn't work on iOS
  BrotherDevice.fromUSBDevice(this.model)
      : source = BrotherDeviceSource.usb,
        modelName = model.nameAndroid,
        ipAddress = null,
        location = null,
        printerName = null,
        serialNumber = null,
        nodeName = null,
        macAddress = null,
        bleAdvertiseLocalName = null;

  @override
  List<Object?> get props => [
        source,
        ipAddress,
        location,
        modelName,
        printerName,
        serialNumber,
        nodeName,
        macAddress,
        bleAdvertiseLocalName,
        model,
      ];

  Map<String, String?> toJson() {
    return {
      'source': source.toJsonString(),
      'ipAddress': ipAddress,
      'location': location,
      'modelName': modelName,
      'printerName': printerName,
      'serialNumber': serialNumber,
      'nodeName': nodeName,
      'macAddress': macAddress,
      'bleAdvertiseLocalName': bleAdvertiseLocalName,
    };
  }

  String get name {
    return [
      printerName,
      modelName,
      bleAdvertiseLocalName,
      nodeName,
      ipAddress,
      serialNumber,
      macAddress,
    ].whereType<String>().first;
  }

  static BrotherModel? _findModel(
    String? modelName,
    String? printerlName,
    String? bleAdvertiseLocalName,
  ) {
    final model = brotherModels.firstWhereOrNull((model) {
      final texts = [
        modelName,
        bleAdvertiseLocalName,
        printerlName,
      ].whereType<String>().map((x) => x.replaceAll('_', '-').replaceAll('Brother', '').replaceAll(' ', '')).toList();

      return texts.any((x) => x.contains(model.nameAndroid));
    });

    return model;
  }

  static BrotherDeviceSource? _findSource(String source) {
    switch (source) {
      case 'network':
        return BrotherDeviceSource.network;
      case 'bluetooth':
        return BrotherDeviceSource.bluetooth;
      case 'ble':
        return BrotherDeviceSource.ble;
      case 'usb':
        return BrotherDeviceSource.usb;
    }

    return null;
  }
}
