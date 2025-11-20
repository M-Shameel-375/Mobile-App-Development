import 'package:flutter/material.dart';
import '../models/device_model.dart';

class DeviceDetailsScreen extends StatefulWidget {
  final DeviceModel device;

  const DeviceDetailsScreen({super.key, required this.device});

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  late bool _isOn;
  late double _intensity;

  @override
  void initState() {
    super.initState();
    _isOn = widget.device.isOn;
    _intensity = widget.device.intensity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: widget.device.color,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // Update device state before going back
                widget.device.isOn = _isOn;
                widget.device.intensity = _intensity;
                Navigator.pop(context);
              },
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.device.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.device.color,
                      widget.device.color.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    widget.device.icon,
                    size: 80,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Device Info Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            Icons.category,
                            'Device Type',
                            widget.device.typeString,
                          ),
                          const Divider(height: 30),
                          _buildInfoRow(
                            Icons.room,
                            'Room',
                            widget.device.room,
                          ),
                          const Divider(height: 30),
                          _buildInfoRow(
                            Icons.info_outline,
                            'Status',
                            _isOn ? 'Active' : 'Inactive',
                            statusColor: _isOn ? Colors.green : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Power Control Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Power Control',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontSize: 18,
                                ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _isOn
                                  ? widget.device.color.withOpacity(0.1)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _isOn
                                    ? widget.device.color
                                    : Colors.grey[300]!,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.power_settings_new,
                                      color: _isOn
                                          ? widget.device.color
                                          : Colors.grey,
                                      size: 28,
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _isOn
                                              ? 'Device is ON'
                                              : 'Device is OFF',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: _isOn
                                                    ? widget.device.color
                                                    : Colors.grey,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _isOn
                                              ? 'Tap to turn off'
                                              : 'Tap to turn on',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(fontSize: 12),
                                        ),
                                      ],
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
                                  activeColor: widget.device.color,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Intensity Control Card (for certain devices)
                  if (widget.device.type != DeviceType.camera &&
                      widget.device.type != DeviceType.doorLock)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.device.intensityLabel} Control',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  _getIntensityIcon(),
                                  color: widget.device.color,
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _intensity,
                                    min: 0,
                                    max: 100,
                                    divisions: 100,
                                    activeColor: widget.device.color,
                                    inactiveColor:
                                        widget.device.color.withOpacity(0.3),
                                    onChanged: _isOn
                                        ? (value) {
                                            setState(() {
                                              _intensity = value;
                                            });
                                          }
                                        : null,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: widget.device.color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${_intensity.toInt()}${_getIntensityUnit()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: widget.device.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            if (!_isOn)
                              Center(
                                child: Text(
                                  'Turn on the device to adjust ${widget.device.intensityLabel.toLowerCase()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Quick Actions
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Actions',
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontSize: 18,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildQuickActionButton(
                                'Schedule',
                                Icons.schedule,
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Schedule feature coming soon!'),
                                    ),
                                  );
                                },
                              ),
                              _buildQuickActionButton(
                                'Timer',
                                Icons.timer,
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Timer feature coming soon!'),
                                    ),
                                  );
                                },
                              ),
                              _buildQuickActionButton(
                                'Settings',
                                Icons.settings,
                                () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Settings feature coming soon!'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value,
      {Color? statusColor}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.device.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: widget.device.color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
      String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.device.color.withOpacity(0.1),
        foregroundColor: widget.device.color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  IconData _getIntensityIcon() {
    switch (widget.device.type) {
      case DeviceType.light:
        return Icons.brightness_6;
      case DeviceType.fan:
        return Icons.speed;
      case DeviceType.ac:
      case DeviceType.thermostat:
        return Icons.thermostat;
      default:
        return Icons.tune;
    }
  }

  String _getIntensityUnit() {
    switch (widget.device.type) {
      case DeviceType.light:
        return '%';
      case DeviceType.fan:
        return '%';
      case DeviceType.ac:
      case DeviceType.thermostat:
        return '°C';
      default:
        return '%';
    }
  }
}
