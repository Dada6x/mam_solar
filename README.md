# mam-solarbau Field Protocol App

An offline-first Flutter mobile application for field workers to fill structured protocol forms and export them as professional PDFs.

## Features

- 4 protocol types: AC Acceptance, Work Order, Damage Report, Installation Report
- Offline-first with local SQLite database (Drift)
- PDF generation with professional layout
- Signature capture via touchscreen
- Photo capture from camera/gallery
- Multi-language: English, German, Arabic (RTL support)
- Autosave with 800ms debounce
- Material 3 design with green/yellow theme

## Setup Instructions

### Prerequisites

- Flutter SDK >=3.11.5
- Dart SDK >=3.11.5

### Installation

```bash
# Get dependencies
flutter pub get

# Generate code (freezed models, drift database, localization)
dart run build_runner build --delete-conflicting-outputs

# Generate localization files
flutter gen-l10n
```

### Running on Android

```bash
flutter run -d android
```

### Running on iOS

```bash
cd ios && pod install && cd ..
flutter run -d ios
```

### Running build_runner

When you modify any Freezed model, Drift database, or JSON serializable class, run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

For continuous code generation during development:

```bash
dart run build_runner watch --delete-conflicting-outputs
```

## Project Structure

```
lib/
├── core/               # Theme, constants, utilities, DI
├── l10n/               # Localization ARB files
├── features/
│   ├── home/           # Home screen with dashboard
│   ├── onboarding/     # First-launch onboarding
│   ├── protocols/      # Form definitions, BLoC, UI
│   ├── pdf/            # PDF generation and preview
│   ├── signatures/     # Signature capture
│   ├── drafts/         # Saved drafts list
│   └── settings/       # Language and app settings
├── data/
│   ├── database/       # Drift SQLite database
│   ├── models/         # Freezed data models
│   └── repositories/   # Data access layer
└── main.dart
```

## Known Limitations

- No cloud sync or backup
- No web or desktop support
- Dynamic form builder not implemented (forms are hardcoded templates)
- No authentication
- Signature pad requires syncfusion_flutter_signaturepad license (free for development)
- Photos and signatures stored as local files (not encrypted)

- each protocol what it dose got untill now (at least what i know )

AC instillaion
Work تكليف
Damage
Instillation

# TODO

- make if the thing is null not to show in the final PDF
- if inverters are 0 and go generate pdf it bugs out
