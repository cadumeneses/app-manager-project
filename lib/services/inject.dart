import 'package:get_it/get_it.dart';
import '../services/dio.dart';

GetIt getIt = GetIt.instance;

void inject() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
//  getIt.registerLazySingleton(() => DioClient());
}