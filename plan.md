# mam-solarbau Field Protocol App — Implementation Plan

## Architecture Overview

A Flutter mobile application for field workers to fill structured protocol forms and export them as professional PDFs. Offline-first, local-only, no backend.

## Tech Stack

- **State Management**: flutter_bloc (BLoC pattern with Freezed)
- **DI**: get_it
- **Navigation**: go_router
- **Database**: Drift (SQLite)
- **PDF**: pdf + printing packages
- **Localization**: Flutter built-in (flutter_localizations + intl + ARB files)
- **Responsive**: sized_context
- **Signatures**: syncfusion_flutter_signaturepad

## Folder Structure

```
lib/
├── core/
│   ├── constants/        # AppColors, AppRoutes
│   ├── theme/            # AppTheme
│   ├── utils/            # DateFormatter, PdfNamingUtil
│   ├── services/         # GetIt injection
│   └── di/               # DI modules
├── l10n/                 # ARB files
├── features/
│   ├── home/             # HomeScreen
│   ├── onboarding/       # Onboarding
│   ├── protocols/        # Protocol forms, BLoC, widgets
│   ├── pdf/              # PDF generation + preview
│   ├── signatures/       # Signature capture
│   ├── drafts/           # Saved drafts list
│   └── settings/         # Settings (language, about)
├── data/
│   ├── database/         # Drift DB + tables
│   ├── models/           # Freezed models
│   └── repositories/     # Data repositories
└── main.dart
```

## File Generation Order

1. pubspec.yaml
2. l10n/app_en.arb, app_de.arb, app_ar.arb
3. lib/core/constants/app_colors.dart
4. lib/core/theme/app_theme.dart
5. lib/data/database/tables/
6. lib/data/database/app_database.dart
7. lib/data/models/
8. lib/data/repositories/
9. lib/core/services/injection.dart
10. lib/core/constants/app_routes.dart
11. lib/features/settings/
12. lib/features/home/
13. lib/features/onboarding/
14. lib/features/protocols/forms/
15. lib/features/protocols/bloc/
16. lib/features/protocols/view/ + widgets/
17. lib/features/signatures/
18. lib/features/pdf/generators/
19. lib/features/pdf/view/
20. lib/features/drafts/
21. lib/main.dart

## Key Design Decisions

- Forms are hardcoded templates (no dynamic form builder)
- All logic in BLoC (not in widgets)
- Autosave with 800ms debounce
- Material 3 with green/yellow color scheme
- RTL support for Arabic
