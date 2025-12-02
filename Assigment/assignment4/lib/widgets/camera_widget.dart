import 'dart:io' show File;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraWidget extends StatefulWidget {
  final Function(String)? onImageCaptured;

  const CameraWidget({super.key, this.onImageCaptured});

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;
  Uint8List? _imageBytes; // For web
  bool _isLoading = false;

  Future<void> _captureImage() async {
    setState(() => _isLoading = true);
    try {
      final XFile? image = await _picker.pickImage(
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
          setState(() => _imagePath = image.path);
        }
        widget.onImageCaptured?.call(image.path);
      }
    } catch (e) {
      debugPrint('Failed to capture image: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickFromGallery() async {
    setState(() => _isLoading = true);
    try {
      final XFile? image = await _picker.pickImage(
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
          setState(() => _imagePath = image.path);
        }
        widget.onImageCaptured?.call(image.path);
      }
    } catch (e) {
      debugPrint('Failed to pick image: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildImageWidget() {
    if (_imagePath == null) {
      return const Center(
        child: Icon(Icons.camera_alt, size: 64, color: Colors.grey),
      );
    }

    if (kIsWeb && _imageBytes != null) {
      return Image.memory(_imageBytes!, fit: BoxFit.cover);
    } else if (!kIsWeb) {
      return Image.file(File(_imagePath!), fit: BoxFit.cover);
    }

    return const Center(child: Icon(Icons.image, size: 64, color: Colors.grey));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildImageWidget(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _captureImage,
              icon: const Icon(Icons.camera),
              label: const Text('Capture'),
            ),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _pickFromGallery,
              icon: const Icon(Icons.photo_library),
              label: const Text('Gallery'),
            ),
          ],
        ),
      ],
    );
  }
}
