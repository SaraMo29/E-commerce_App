
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasource/loginservice.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/products/data/datasources/products_api_datasource.dart';
import '../../features/products/data/datasources/reviews_local_datasource.dart';
import '../../features/products/data/repositories/products_repository.dart';
import '../../features/products/data/repositories/products_repository_impl.dart';
import '../network/api_endpoints.dart';
import '../network/dio_client.dart';
import '../network/token_storage.dart';

/// Global service locator instance.
final getIt = GetIt.instance;

/// Registers the network stack and feature services.
///
/// Call once from main() after WidgetsFlutterBinding.ensureInitialized().
Future<void> configureDependencies() async {
  // Core: SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Local token storage
  getIt.registerLazySingleton<TokenStorage>(
    () => SharedPrefsTokenStorage(
      getIt<SharedPreferences>(),
    ),
  );

  // Dio
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: ApiEndpoints.connectTimeout,
        receiveTimeout: ApiEndpoints.receiveTimeout,
        sendTimeout: ApiEndpoints.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        responseType: ResponseType.json,
      ),
    ),
  );

  // DioClient
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      dio: getIt<Dio>(),
      tokenStorage: getIt<TokenStorage>(),
    ),
  );

  // Auth
  getIt.registerLazySingleton<LoginService>(
    () => LoginService(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      loginService: getIt<LoginService>(),
      tokenStorage: getIt<TokenStorage>(),
    ),
  );

  // Products API datasource
  getIt.registerLazySingleton<ProductsApiDatasource>(
    () => ProductsApiDatasource(),
  );

  // Products reviews local datasource (Hive)
  getIt.registerLazySingleton<ReviewsLocalDatasource>(
    () => ReviewsLocalDatasource(),
  );

  // Products repository
  getIt.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(
      datasource: getIt<ProductsApiDatasource>(),
      reviewsLocalDatasource: getIt<ReviewsLocalDatasource>(),
    ),
  );
}
