import 'package:get_it/get_it.dart';
import 'package:mam_solar/data/database/app_database.dart';
import 'package:mam_solar/data/repositories/protocol_repository.dart';
import 'package:mam_solar/data/repositories/signature_repository.dart';
import 'package:mam_solar/features/settings/bloc/settings_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerSingleton<AppDatabase>(AppDatabase());

  sl.registerSingleton<ProtocolRepository>(
    ProtocolRepository(sl<AppDatabase>()),
  );

  sl.registerSingleton<SignatureRepository>(
    SignatureRepository(sl<AppDatabase>()),
  );

  sl.registerSingleton<SettingsBloc>(SettingsBloc());
}
