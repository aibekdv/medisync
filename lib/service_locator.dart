import 'package:get_it/get_it.dart';
import 'package:medisync/feature/data/datasources/datasources.dart';
import 'package:medisync/feature/data/repositories/medicate_repository_impl.dart';
import 'package:medisync/feature/domain/repositories/medicate_repository.dart';
import 'package:medisync/feature/domain/usecases/usecases.dart';
import 'package:medisync/feature/presentation/cubit/cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

// GET_IT INSTANCE
final sl = GetIt.instance;

// DEPENDENCY INJECTION
Future<void> init() async {
  // CUBIT (BLOC)
  sl.registerFactory(() => LangCubit(sl()));
  sl.registerFactory(() => MedicationCubit(sl()));

  // USER USECASES
  sl.registerLazySingleton(() => GetMedicationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => DeleteMedicationUseCase(repository: sl()));
  sl.registerLazySingleton(() => UpdateMedicationUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddMedicationUseCase(repository: sl()));

  //  REPOSITORIES
  sl.registerLazySingleton<DatabaseService>(() => DatabaseService());
  sl.registerLazySingleton<MedicationDataSource>(
    () => MedicationDataSourceImpl(databaseService: sl()),
  );

  sl.registerLazySingleton<MedicateRepository>(
    () => MedicateRepositoryImpl(remoteDataSource: sl()),
  );

  // EXTERNAL
  final sharedPrefences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefences);
}
