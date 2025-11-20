import 'package:flutter/material.dart';
import '../models/device_model.dart';
import '../widgets/device_card.dart';
import '../widgets/add_device_dialog.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<DeviceModel> devices = [
    DeviceModel(
      id: '1',
      name: 'Living Room Light',
      type: DeviceType.light,
      room: 'Living Room',
      isOn: true,
      intensity: 75,
    ),
    DeviceModel(
      id: '2',
      name: 'Bedroom Fan',
      type: DeviceType.fan,
      room: 'Bedroom',
      isOn: false,
      intensity: 60,
    ),
    DeviceModel(
      id: '3',
      name: 'Office AC',
      type: DeviceType.ac,
      room: 'Office',
      isOn: true,
      intensity: 22,
    ),
    DeviceModel(
      id: '4',
      name: 'Front Door Camera',
      type: DeviceType.camera,
      room: 'Entrance',
      isOn: true,
    ),
    DeviceModel(
      id: '5',
      name: 'Kitchen Light',
      type: DeviceType.light,
      room: 'Kitchen',
      isOn: false,
      intensity: 80,
    ),
    DeviceModel(
      id: '6',
      name: 'Main Door Lock',
      type: DeviceType.doorLock,
      room: 'Entrance',
      isOn: true,
    ),
  ];

  void _toggleDevice(String id, bool value) {
    setState(() {
      final index = devices.indexWhere((device) => device.id == id);
      if (index != -1) {
        devices[index].isOn = value;
      }
    });
  }

  void _addNewDevice(DeviceModel device) {
    setState(() {
      devices.add(device);
    });

    // Show success snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text('${device.name} added successfully!'),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showAddDeviceDialog() {
    showDialog(
      context: context,
      builder: (context) => AddDeviceDialog(
        onAddDevice: _addNewDevice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;
    final crossAxisCount = isTablet ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Menu action
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menu pressed')),
            );
          },
        ),
        title: const Text('Smart Home Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Home! 👋',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You have ${devices.where((d) => d.isOn).length} devices turned on',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            // Devices Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];
                    return DeviceCard(
                      device: device,
                      onToggle: (value) => _toggleDevice(device.id, value),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDeviceDialog,
        icon: const Icon(Icons.add),
        label: const Text('Add Device'),
      ),
    );
  }
}
