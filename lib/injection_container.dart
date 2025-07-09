import 'package:get_it/get_it.dart';
import 'package:gudang_market_fish/screens/auth/blocs/auth_bloc.dart';
import 'package:gudang_market_fish/screens/home/blocs/product_bloc.dart';
import 'package:gudang_market_fish/screens/home/blocs/ui_cubit.dart';
import 'package:gudang_market_fish/screens/profile/blocs/address_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import 'components/address/data/datasources/address_remote_data_source.dart';
import 'components/address/data/repositories/address_repository_impl.dart';
import 'components/address/domain/repositories/address_repository.dart';
import 'components/address/domain/usecases/add_address_usecase.dart';
import 'components/address/domain/usecases/delete_address_usecase.dart';
import 'components/address/domain/usecases/get_addresses_usecase.dart';
import 'components/auth/data/datasources/product_remote_data_source.dart';
import 'components/auth/data/repositories/product_repository_impl.dart';
import 'components/auth/domain/repositories/product_repository.dart';
import 'components/auth/domain/usecases/logout_usecase.dart';
import 'components/auth/domain/usecases/register_usecase.dart';
import 'core/network/api_service.dart';
import 'core/network/network_info.dart';
import 'components/auth/data/datasources/auth_remote_data_source.dart';
import 'components/auth/data/repositories/auth_repository_impl.dart';
import 'components/auth/domain/repositories/auth_repository.dart';
import 'components/auth/domain/usecases/login_usecase.dart';
import 'core/usecases/get_products.dart';
import 'core/usecases/register_product.dart';
import 'core/utils/constants.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerFactory(() => UiCubit());

  // Core
  sl.registerLazySingleton(() => ApiService(
    baseUrl: ApiConstants.baseUrl,
    client: sl(),
  ));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Auth Feature
  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(apiService: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  // Bloc
  sl.registerFactory(() => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
  ));

  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => RegisterProduct(sl()));

  sl.registerFactory(() => ProductBloc(
    getProducts: sl(),
    registerProduct: sl(), // Inject use case baru
  ));


  // Product Feature
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(apiService: sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Address Feature

  // Add the new use case
  sl.registerFactory(() => AddAddress(sl()));
  sl.registerFactory(() => GetAddresses(sl()));
  sl.registerFactory(() => DeleteAddress(sl()));

  sl.registerFactory(() => AddressBloc(
    getAddresses: sl(),
    addAddress: sl(),
    deleteAddress: sl(),
  ));

  sl.registerLazySingleton<AddressRemoteDataSource>(() => AddressRemoteDataSourceImpl(
    apiService: sl(),
  ));

  sl.registerLazySingleton<AddressRepository>(() => AddressRepositoryImpl(
    remoteDataSource: sl(),
    networkInfo: sl(),
  ));
}