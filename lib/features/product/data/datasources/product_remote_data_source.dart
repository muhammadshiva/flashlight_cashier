import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../../../../core/pagination/paginated_response_model.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<PaginatedResponseModel<ProductModel>> getProducts({
    String? type,
    PaginationParams? pagination,
  });
  Future<ProductModel> createProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<PaginatedResponseModel<ProductModel>> getProducts({
    String? type,
    PaginationParams? pagination,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (type != null) queryParams['type'] = type;
      if (pagination != null) queryParams.addAll(pagination.toQueryParams());

      final response = await dio.get(
        '/products',
        queryParameters: queryParams,
      );

      final result = response.data;
      if (result is Map<String, dynamic> && result.containsKey('data')) {
        return PaginatedResponseModel<ProductModel>.fromJson(
          result,
          (json) => ProductModel.fromJson(json as Map<String, dynamic>),
        );
      }

      throw ServerFailure('Invalid response format');
    } catch (e) {
      // Return generated dummy data on failure (simulating 50 items)
      final allProducts = List.generate(50, (index) {
        final id = (index + 1).toString();
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
        final productType = types[index % types.length];
        final isAvailable = index % 5 != 0;

        return ProductModel(
          id: 'PROD-${id.padLeft(4, '0')}',
          name: 'Premium $productType Item #$id',
          description:
              'High-quality $productType replacement part for various vehicle models.',
          price: (10 + (index * 5)) % 200 + 15,
          imageUrl: '',
          type: productType,
          stock: isAvailable ? (index * 7) % 100 + 5 : 0,
          isAvailable: isAvailable,
        );
      });

      // Apply pagination
      final page = pagination?.page ?? 1;
      final limit = pagination?.limit ?? 10;
      final offset = pagination?.offset ?? 0;

      final total = allProducts.length;
      final totalPages = (total / limit).ceil();
      final startIndex = ((page - 1) * limit) + offset;
      final endIndex = (startIndex + limit).clamp(0, total);

      final paginatedData = allProducts.sublist(
        startIndex.clamp(0, total),
        endIndex,
      );

      return PaginatedResponseModel<ProductModel>(
        data: paginatedData,
        total: total,
        page: page,
        limit: limit,
        totalPages: totalPages,
      );
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
