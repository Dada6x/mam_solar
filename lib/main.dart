import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/core/constants/app_routes.dart';
import 'package:mam_solar/core/theme/app_theme.dart';
import 'package:mam_solar/core/services/injection.dart';
import 'package:mam_solar/features/settings/bloc/settings_bloc.dart';
import 'package:mam_solar/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(MamSolarApp());
}

class MamSolarApp extends StatefulWidget {
  const MamSolarApp({super.key});

  @override
  State<MamSolarApp> createState() => _MamSolarAppState();
}

class _MamSolarAppState extends State<MamSolarApp> {
  late final GoRouter _router;
  late final SettingsBloc _settingsBloc;

  @override
  void initState() {
    super.initState();
    _settingsBloc = sl<SettingsBloc>();
    _settingsBloc.add(const LoadLanguage());
    _router = AppRoutes.router;
  }

  @override
  void dispose() {
    _settingsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF2e7d32),
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Color(0xFF2e7d32),
        statusBarIconBrightness: Brightness.light,
      ),
      child: SafeArea(
        child: BlocProvider.value(
          value: _settingsBloc,
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              final locale = Locale(state.languageCode);
              return MaterialApp.router(
                title: 'mam-solarbau',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                locale: locale,
                supportedLocales: const [
                  Locale('en'),
                  Locale('de'),
                  Locale('ar'),
                ],
                localizationsDelegates: [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  if (locale != null) {
                    for (final supported in supportedLocales) {
                      if (supported.languageCode == locale.languageCode) {
                        return supported;
                      }
                    }
                  }
                  return supportedLocales.first;
                },
                routerConfig: _router,
              );
            },
          ),
        ),
      ),
    );
  }
}
