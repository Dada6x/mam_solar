import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mam_solar/core/constants/app_colors.dart';

class FileFieldWidget extends StatefulWidget {
  final String? filePath;
  final ValueChanged<String?> onChanged;
  final String label;
  final List<String>? acceptedFormats;

  const FileFieldWidget({
    super.key,
    this.filePath,
    required this.onChanged,
    required this.label,
    this.acceptedFormats,
  });

  @override
  State<FileFieldWidget> createState() => _FileFieldWidgetState();
}

class _FileFieldWidgetState extends State<FileFieldWidget> {
  String? _filePath;
  String? _fileName;

  @override
  void initState() {
    super.initState();
    _filePath = widget.filePath;
    _updateFileName();
  }

  void _updateFileName() {
    if (_filePath != null && _filePath!.isNotEmpty) {
      _fileName = _filePath!.split('/').last;
    } else {
      _fileName = null;
    }
  }

  Future<void> _pickFile() async {
    final allowedExtensions = widget.acceptedFormats?.map((f) => f.trim()).toList();
    final result = await FilePicker.pickFiles(
      type: allowedExtensions != null ? FileType.custom : FileType.any,
      allowedExtensions: allowedExtensions,
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _filePath = result.files.single.path;
        _fileName = result.files.single.name;
      });
      widget.onChanged(_filePath);
    }
  }

  void _clearFile() {
    setState(() {
      _filePath = null;
      _fileName = null;
    });
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
        if (_filePath != null && File(_filePath!).existsSync())
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.attach_file, size: 20, color: AppColors.primaryGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _fileName ?? _filePath!,
                        style: const TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: InkWell(
                  onTap: _clearFile,
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
          OutlinedButton.icon(
            onPressed: _pickFile,
            icon: const Icon(Icons.upload_file, size: 18),
            label: const Text('Datei auswählen', style: TextStyle(fontSize: 12)),
          ),
      ],
    );
  }
}
