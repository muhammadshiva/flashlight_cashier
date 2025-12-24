import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> createProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
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
    } catch (e) {
      // Return generated dummy data on failure (simulating 50 items)
      return List.generate(50, (index) {
        final id = (index + 1).toString();
        // Cycle through types to vary data
        final types = [
          'Brakes',
          'Oil',
          'Filter',
          'Ignition',
          'Battery',
          'Wipers',
          'Coolant',
          'Tires',
          'Lights',
          'Interior'
        ];
        final type = types[index % types.length];
        final isAvailable = index % 5 != 0; // Every 5th item is unavailable

        return ProductModel(
          id: 'PROD-${id.padLeft(4, '0')}', // e.g. PROD-0001
          name: 'Premium $type Item #$id',
          description:
              'High-quality $type replacement part for various vehicle models.',
          price: (10 + (index * 5)) % 200 + 15, // Varied price
          imageUrl: '',
          type: type,
          stock: isAvailable ? (index * 7) % 100 + 5 : 0,
          isAvailable: isAvailable,
        );
      });
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
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      final response =
          await dio.put('/products/${product.id}', data: product.toJson());
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
