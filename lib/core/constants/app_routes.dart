import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mam_solar/features/home/view/home_screen.dart';
import 'package:mam_solar/features/protocols/view/protocol_type_screen.dart';
import 'package:mam_solar/features/protocols/view/dynamic_form_screen.dart';
import 'package:mam_solar/features/signatures/view/signature_screen.dart';
import 'package:mam_solar/features/pdf/view/pdf_preview_screen.dart';
import 'package:mam_solar/features/drafts/view/saved_drafts_screen.dart';
import 'package:mam_solar/features/completed/view/completed_protocols_screen.dart';
import 'package:mam_solar/features/settings/view/settings_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String protocolType = '/protocol-type';
  static const String form = '/form/:type';
  static const String formWithId = '/form/:type/:id';
  static const String signature = '/signature/:protocolId/:signatureType';
  static const String pdfPreview = '/pdf-preview/:protocolId';
  static const String drafts = '/drafts';
  static const String completed = '/completed';
  static const String settings = '/settings';

  static final RouteObserver<ModalRoute> routeObserver =
      RouteObserver<ModalRoute>();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    observers: [routeObserver],
    routes: [
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/protocol-type',
        builder: (context, state) => const ProtocolTypeScreen(),
      ),
      GoRoute(
        path: '/form/:type',
        builder: (context, state) {
          final type = state.pathParameters['type']!;
          final id = state.uri.queryParameters['id'];
          return DynamicFormScreen(
            protocolType: type,
            protocolId: id != null ? int.tryParse(id) : null,
          );
        },
      ),
      GoRoute(
        path: '/form/:type/:id',
        builder: (context, state) {
          final type = state.pathParameters['type']!;
          final idStr = state.pathParameters['id']!;
          return DynamicFormScreen(
            protocolType: type,
            protocolId: int.tryParse(idStr),
          );
        },
      ),
      GoRoute(
        path: '/signature/:protocolId/:signatureType',
        builder: (context, state) {
          final protocolId = int.parse(state.pathParameters['protocolId']!);
          final sigType = state.pathParameters['signatureType']!;
          return SignatureScreen(
            protocolId: protocolId,
            signatureType: sigType,
          );
        },
      ),
      GoRoute(
        path: '/pdf-preview/:protocolId',
        builder: (context, state) {
          final protocolId = int.parse(state.pathParameters['protocolId']!);
          return PdfPreviewScreen(protocolId: protocolId);
        },
      ),
      GoRoute(
        path: '/drafts',
        builder: (context, state) => const SavedDraftsScreen(),
      ),
      GoRoute(
        path: '/completed',
        builder: (context, state) => const CompletedProtocolsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
