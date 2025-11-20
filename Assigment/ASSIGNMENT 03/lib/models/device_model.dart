import 'package:flutter/material.dart';

enum DeviceType {
  light,
  fan,
  ac,
  camera,
  thermostat,
  doorLock,
}

class DeviceModel {
  final String id;
  final String name;
  final DeviceType type;
  final String room;
  bool isOn;
  double intensity; // For brightness/speed/temperature

  DeviceModel({
    required this.id,
    required this.name,
    required this.type,
    required this.room,
    this.isOn = false,
    this.intensity = 50.0,
  });

  String get statusText => isOn ? 'ON' : 'OFF';

  String get typeString {
    switch (type) {
      case DeviceType.light:
        return 'Light';
      case DeviceType.fan:
        return 'Fan';
      case DeviceType.ac:
        return 'Air Conditioner';
      case DeviceType.camera:
        return 'Camera';
      case DeviceType.thermostat:
        return 'Thermostat';
      case DeviceType.doorLock:
        return 'Door Lock';
    }
  }

  IconData get icon {
    switch (type) {
      case DeviceType.light:
        return Icons.lightbulb;
      case DeviceType.fan:
        return Icons.wind_power;
      case DeviceType.ac:
        return Icons.ac_unit;
      case DeviceType.camera:
        return Icons.videocam;
      case DeviceType.thermostat:
        return Icons.thermostat;
      case DeviceType.doorLock:
        return Icons.lock;
    }
  }

  Color get color {
    switch (type) {
      case DeviceType.light:
        return Colors.amber;
      case DeviceType.fan:
        return Colors.blue;
      case DeviceType.ac:
        return Colors.cyan;
      case DeviceType.camera:
        return Colors.red;
      case DeviceType.thermostat:
        return Colors.orange;
      case DeviceType.doorLock:
        return Colors.green;
    }
  }

  String get intensityLabel {
    switch (type) {
      case DeviceType.light:
        return 'Brightness';
      case DeviceType.fan:
        return 'Speed';
      case DeviceType.ac:
      case DeviceType.thermostat:
        return 'Temperature';
      default:
        return 'Intensity';
    }
  }
}
