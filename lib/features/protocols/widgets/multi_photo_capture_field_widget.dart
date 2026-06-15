import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mam_solar/features/protocols/widgets/dashed_box.dart';
import 'package:mam_solar/features/protocols/widgets/required_label.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

class MultiPhotoCaptureFieldWidget extends StatefulWidget {
  final List<String> imagePaths;
  final ValueChanged<List<String>> onChanged;
  final String label;
  final bool required;

  const MultiPhotoCaptureFieldWidget({
    super.key,
    required this.imagePaths,
    required this.onChanged,
    required this.label,
    this.required = false,
  });

  @override
  State<MultiPhotoCaptureFieldWidget> createState() => _MultiPhotoCaptureFieldWidgetState();
}

class _MultiPhotoCaptureFieldWidgetState extends State<MultiPhotoCaptureFieldWidget> {
  final _picker = ImagePicker();

  Future<void> _takePhoto() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (file != null) {
        widget.onChanged([...widget.imagePaths, file.path]);
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
      final files = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (files.isNotEmpty) {
        widget.onChanged([...widget.imagePaths, ...files.map((f) => f.path)]);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.failedToPickImage)),
        );
      }
    }
  }

  void _removePhoto(int index) {
    final updated = List<String>.from(widget.imagePaths)..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final validPaths = widget.imagePaths.where((p) => File(p).existsSync()).toList();
    final hasPhotos = validPaths.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RequiredFieldLabel(text: widget.label, required: widget.required),
        const SizedBox(height: 8),
        if (hasPhotos)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.imagePaths.asMap().entries.map((e) {
              final idx = e.key;
              final path = e.value;
              final exists = File(path).existsSync();
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 64) / 2,
                child: exists
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(path),
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: InkWell(
                              onTap: () => _removePhoto(idx),
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
                    : const SizedBox.shrink(),
              );
            }).toList(),
          ),
        if (hasPhotos) const SizedBox(height: 8),
        PhotoSourceBox(
          onCamera: _takePhoto,
          onGallery: _pickFromGallery,
          cameraLabel: AppLocalizations.of(context)!.camera,
          galleryLabel: AppLocalizations.of(context)!.gallery,
        ),
      ],
    );
  }
}
