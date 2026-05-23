import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:mam_solar/core/parsers/protocol_md_parser.dart';

class ImportProtocolButton extends StatelessWidget {
  const ImportProtocolButton({super.key});

  static Future<bool> _isDevMode() async {
    if (kDebugMode) return true;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('dev_mode') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isDevMode(),
      builder: (context, snapshot) {
        if (snapshot.data != true) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _SectionTitle(title: 'Developer Tools'),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.upload_file),
                    title: const Text('Import Protocol Template (.md)'),
                    subtitle: const Text('Override bundled protocol definitions'),
                    onTap: () => _importProtocol(context),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.restore),
                    title: const Text('Reset Protocol Templates'),
                    subtitle: const Text('Revert to built-in definitions'),
                    onTap: () => _showResetDialog(context),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _importProtocol(BuildContext context) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['md'],
      );

      if (result == null || result.files.isEmpty) return;

      final file = result.files.first;
      if (file.path == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not read file')),
          );
        }
        return;
      }

      final content = await File(file.path!).readAsString();

      if (!content.contains('---') || !content.contains('protocol:')) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid protocol file')),
          );
        }
        return;
      }

      final typeMatch = RegExp(r'^protocol:\s*(.+)$', multiLine: true).firstMatch(content);
      if (typeMatch == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Missing protocol type in frontmatter')),
          );
        }
        return;
      }

      final type = typeMatch.group(1)!.trim();

      await ProtocolMdParser.saveOverride(type, content);

      try {
        await ProtocolMdParser.parseForce(type);
      } catch (e) {
        await ProtocolMdParser.removeOverride(type);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File has errors: $e')),
          );
        }
        return;
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Protocol '$type' updated successfully. Reload the form to see changes."),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Import failed: $e')),
        );
      }
    }
  }

  Future<void> _showResetDialog(BuildContext context) async {
    final types = await ProtocolMdParser.availableTypes();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Protocol Templates'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              ...types.map((type) => ListTile(
                title: Text(type),
                trailing: const Icon(Icons.restore),
                onTap: () async {
                  await ProtocolMdParser.removeOverride(type);
                  Navigator.of(ctx).pop();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Reset '$type' to built-in template.")),
                    );
                  }
                },
              )),
              ListTile(
                leading: const Icon(Icons.restore_page),
                title: const Text('Reset All'),
                onTap: () async {
                  for (final t in types) {
                    await ProtocolMdParser.removeOverride(t);
                  }
                  Navigator.of(ctx).pop();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All templates reset to built-in.')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
