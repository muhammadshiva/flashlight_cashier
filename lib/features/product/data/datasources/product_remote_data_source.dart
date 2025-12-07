import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> createProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get('/products');
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      final response = await dio.post('/products', data: product.toJson());
      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      await dio.delete('/products/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
