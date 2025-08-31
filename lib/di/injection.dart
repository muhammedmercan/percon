import 'package:get_it/get_it.dart';
import 'package:percon/data/repositories/auth_repository_impl.dart';
import 'package:percon/data/repositories/travel_repository_impl.dart';
import 'package:percon/domain/repositories/auth_repository.dart';
import 'package:percon/domain/repositories/travel_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(),
  );

  getIt.registerLazySingleton<TravelRepository>(
    () => TravelRepositoryImpl(),
  );
}
