import 'package:flutter/material.dart';
import '../models/device_model.dart';

class DeviceIcons {
  static IconData getIconForDeviceType(DeviceType type) {
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

  static Color getColorForDeviceType(DeviceType type) {
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
}
