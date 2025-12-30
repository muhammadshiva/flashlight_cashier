import 'package:get_it/get_it.dart';

import '../../../core/network/dio_client.dart';
import '../../../features/product/data/datasources/product_remote_data_source.dart';
import '../../../features/product/data/repositories/product_repository_impl.dart';
import '../../../features/product/domain/repositories/product_repository.dart';
import '../../../features/product/domain/usecases/product_usecases.dart';
import '../../../features/product/domain/usecases/update_product.dart';
import '../../../features/product/presentation/bloc/product_bloc.dart';

final _sl = GetIt.instance;

/// Dependency injection configuration for the Product feature.
class ProductInjector {
  static void init() {
    // ============================================
    // BLoCs - Register as Factory
    // ============================================
    _sl.registerFactory<ProductBloc>(
      () => ProductBloc(
        getProducts: _sl(),
        createProduct: _sl(),
        updateProduct: _sl(),
        deleteProduct: _sl(),
      ),
    );

    // ============================================
    // Use Cases - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<GetProducts>(
      () => GetProducts(_sl()),
    );

    _sl.registerLazySingleton<CreateProduct>(
      () => CreateProduct(_sl()),
    );

    _sl.registerLazySingleton<UpdateProduct>(
      () => UpdateProduct(_sl()),
    );

    _sl.registerLazySingleton<DeleteProduct>(
      () => DeleteProduct(_sl()),
    );

    // ============================================
    // Repository - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: _sl()),
    );

    // ============================================
    // Data Sources - Register as Lazy Singleton
    // ============================================
    _sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(dio: _sl<DioClient>().dio),
    );
  }
}
