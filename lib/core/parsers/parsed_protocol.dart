import 'package:mam_solar/features/protocols/forms/form_definition.dart';

class ParsedProtocol {
  final String type;
  final String title;
  final String? titleDe;
  final String? titleAr;
  final String version;
  final List<FormSection> sections;

  const ParsedProtocol({
    required this.type,
    required this.title,
    this.titleDe,
    this.titleAr,
    required this.version,
    required this.sections,
  });

  String localizedTitle(String languageCode) {
    if (languageCode == 'de' && titleDe != null) return titleDe!;
    if (languageCode == 'ar' && titleAr != null) return titleAr!;
    return title;
  }
}
