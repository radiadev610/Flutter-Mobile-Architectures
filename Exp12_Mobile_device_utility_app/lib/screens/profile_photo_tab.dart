import 'dart:io';
import 'package:flutter/material.dart';
import '../services/media_service.dart';
import '../services/permission_service.dart';

class ProfilePhotoTab extends StatefulWidget {
  const ProfilePhotoTab({super.key});

  @override
  State<ProfilePhotoTab> createState() => _ProfilePhotoTabState();
}

class _ProfilePhotoTabState extends State<ProfilePhotoTab> {
  final MediaService _mediaService = MediaService();
  File? _selectedImage;

  Future<void> _handleCaptureImage() async {
    final granted = await PermissionService.requestCameraPermission();
    if (!mounted) return;

    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Camera permission was denied.')),
      );
      return;
    }

    final image = await _mediaService.pickImageFromCamera();
    if (image != null) {
      setState(() => _selectedImage = image);
    }
  }

  Future<void> _handleSelectGallery() async {
    final granted = await PermissionService.requestPhotosPermission();
    if (!mounted) return;

    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage/Gallery permission was denied.')),
      );
      return;
    }

    final image = await _mediaService.pickImageFromGallery();
    if (image != null) {
      setState(() => _selectedImage = image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          children: [
            const Text(
              'Profile Photo Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Stack(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : null,
                  child: _selectedImage == null
                      ? const Icon(Icons.person, size: 80, color: Colors.grey)
                      : null,
                ),
                if (_selectedImage != null)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 20,
                      child: IconButton(
                        icon: const Icon(Icons.delete, size: 18, color: Colors.white),
                        onPressed: () => setState(() => _selectedImage = null),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _handleCaptureImage,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Camera'),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: _handleSelectGallery,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Gallery'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}