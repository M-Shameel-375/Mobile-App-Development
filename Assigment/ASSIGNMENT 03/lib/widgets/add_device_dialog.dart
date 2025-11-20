import 'package:flutter/material.dart';
import '../models/device_model.dart';

class AddDeviceDialog extends StatefulWidget {
  final Function(DeviceModel) onAddDevice;

  const AddDeviceDialog({super.key, required this.onAddDevice});

  @override
  State<AddDeviceDialog> createState() => _AddDeviceDialogState();
}

class _AddDeviceDialogState extends State<AddDeviceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roomController = TextEditingController();
  DeviceType _selectedType = DeviceType.light;
  bool _isOn = false;

  @override
  void dispose() {
    _nameController.dispose();
    _roomController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newDevice = DeviceModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        type: _selectedType,
        room: _roomController.text.trim(),
        isOn: _isOn,
      );

      widget.onAddDevice(newDevice);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.add_home,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Add New Device',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 20,
                              ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Device Name
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Device Name',
                    hintText: 'e.g., Living Room Light',
                    prefixIcon: Icon(Icons.devices),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter device name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Device Type Dropdown
                DropdownButtonFormField<DeviceType>(
                  value: _selectedType,
                  decoration: const InputDecoration(
                    labelText: 'Device Type',
                    prefixIcon: Icon(Icons.category),
                  ),
                  items: DeviceType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Row(
                        children: [
                          Icon(
                            _getIconForType(type),
                            size: 20,
                            color: _getColorForType(type),
                          ),
                          const SizedBox(width: 8),
                          Text(_getTypeString(type)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Room Name
                TextFormField(
                  controller: _roomController,
                  decoration: const InputDecoration(
                    labelText: 'Room Name',
                    hintText: 'e.g., Living Room',
                    prefixIcon: Icon(Icons.room),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter room name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // Status Switch
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            color: _isOn ? Colors.green : Colors.grey,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Initial Status',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      Switch(
                        value: _isOn,
                        onChanged: (value) {
                          setState(() {
                            _isOn = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Add Device'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForType(DeviceType type) {
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

  Color _getColorForType(DeviceType type) {
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

  String _getTypeString(DeviceType type) {
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
}
