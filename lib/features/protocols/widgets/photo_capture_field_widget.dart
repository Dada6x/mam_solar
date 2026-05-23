import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mam_solar/core/constants/app_colors.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

class PhotoCaptureFieldWidget extends StatefulWidget {
  final String? imagePath;
  final ValueChanged<String?> onChanged;
  final String label;

  const PhotoCaptureFieldWidget({
    super.key,
    this.imagePath,
    required this.onChanged,
    required this.label,
  });

  @override
  State<PhotoCaptureFieldWidget> createState() => _PhotoCaptureFieldWidgetState();
}

class _PhotoCaptureFieldWidgetState extends State<PhotoCaptureFieldWidget> {
  String? _imagePath;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _imagePath = widget.imagePath;
  }

  Future<void> _takePhoto() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (file != null) {
        setState(() => _imagePath = file.path);
        widget.onChanged(file.path);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.failedToCapturePhoto)),
        );
      }
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (file != null) {
        setState(() => _imagePath = file.path);
        widget.onChanged(file.path);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.failedToPickImage)),
        );
      }
    }
  }

  void _clearPhoto() {
    setState(() => _imagePath = null);
    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 13, color: AppColors.labelGrey),
        ),
        const SizedBox(height: 8),
        if (_imagePath != null && File(_imagePath!).existsSync())
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(_imagePath!),
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: InkWell(
                  onTap: _clearPhoto,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        else
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _takePhoto,
                  icon: const Icon(Icons.camera_alt, size: 18),
                  label: Text(AppLocalizations.of(context)!.camera, style: const TextStyle(fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _pickFromGallery,
                  icon: const Icon(Icons.photo_library, size: 18),
                  label: Text(AppLocalizations.of(context)!.gallery, style: const TextStyle(fontSize: 12)),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
