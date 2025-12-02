import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../models/activity_model.dart';
import '../providers/activity_provider.dart';
import '../services/location_service.dart';
import '../widgets/map_widget.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final LocationService _locationService = LocationService();
  final ImagePicker _imagePicker = ImagePicker();

  double? _currentLatitude;
  double? _currentLongitude;
  String? _imagePath;
  dynamic _imageBytes; // For web
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final position = await _locationService.getCurrentLocation();
      setState(() {
        _currentLatitude = position.latitude;
        _currentLongitude = position.longitude;
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
      });
      _showError('Failed to get location: $e');
    }
  }

  Future<void> _captureImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );
      if (image != null) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          setState(() {
            _imagePath = image.path;
            _imageBytes = bytes;
          });
        } else {
          setState(() {
            _imagePath = image.path;
          });
        }
      }
    } catch (e) {
      _showError('Failed to capture image: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );
      if (image != null) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          setState(() {
            _imagePath = image.path;
            _imageBytes = bytes;
          });
        } else {
          setState(() {
            _imagePath = image.path;
          });
        }
      }
    } catch (e) {
      _showError('Failed to pick image: $e');
    }
  }

  Widget _buildImageWidget() {
    if (_imagePath == null) {
      return Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.image, size: 48, color: Colors.grey),
              SizedBox(height: 8),
              Text('No image captured', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    if (kIsWeb && _imageBytes != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(_imageBytes, height: 150, fit: BoxFit.cover),
      );
    } else if (!kIsWeb) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(File(_imagePath!), height: 150, fit: BoxFit.cover),
      );
    }

    return const Text('Image preview not available');
  }

  Future<void> _saveActivity() async {
    if (_titleController.text.isEmpty) {
      _showError('Please enter a title');
      return;
    }

    if (_currentLatitude == null || _currentLongitude == null) {
      _showError('Unable to get current location');
      return;
    }

    final activity = Activity(
      title: _titleController.text,
      description: _descriptionController.text,
      latitude: _currentLatitude!,
      longitude: _currentLongitude!,
      imagePath: _imagePath,
      timestamp: DateTime.now(),
    );

    final provider = Provider.of<ActivityProvider>(context, listen: false);
    await provider.addActivity(activity);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Activity saved successfully!')),
      );

      // Reset form
      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _imagePath = null;
        _imageBytes = null;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Activity Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          // Location Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Location',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  _isLoadingLocation
                      ? const Center(child: CircularProgressIndicator())
                      : _currentLatitude != null
                      ? Column(
                          children: [
                            Text(
                              'Lat: ${_currentLatitude!.toStringAsFixed(6)}, '
                              'Lng: ${_currentLongitude!.toStringAsFixed(6)}',
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 200,
                              child: MapWidget(
                                latitude: _currentLatitude!,
                                longitude: _currentLongitude!,
                                markers: kIsWeb
                                    ? const {}
                                    : {
                                        Marker(
                                          markerId: const MarkerId('current'),
                                          position: LatLng(
                                            _currentLatitude!,
                                            _currentLongitude!,
                                          ),
                                        ),
                                      },
                              ),
                            ),
                          ],
                        )
                      : const Text('Location not available'),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _getCurrentLocation,
                    icon: const Icon(Icons.location_on),
                    label: const Text('Refresh Location'),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Camera Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Photo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  _buildImageWidget(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _captureImage,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('Camera'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _pickFromGallery,
                          icon: const Icon(Icons.photo_library),
                          label: const Text('Gallery'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: _saveActivity,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Save Activity', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
