import 'package:dio/dio.dart';

import '../../../../core/constants/api_constans.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/pagination/paginated_response_model.dart';
import '../../../../core/pagination/pagination_params.dart';
import '../models/product_model.dart';

/// Abstract interface for product remote data operations.
abstract class ProductRemoteDataSource {
  /// Gets paginated list of products from the API.
  /// Supports optional [type] filter and [pagination] params.
  Future<PaginatedResponseModel<ProductModel>> getProducts({
    String? type,
    PaginationParams? pagination,
  });

  /// Creates a new product via the API.
  Future<ProductModel> createProduct(ProductModel product);

  /// Updates an existing product via the API.
  Future<ProductModel> updateProduct(ProductModel product);

  /// Deletes a product by [id] via the API.
  Future<void> deleteProduct(String id);
}

/// Implementation of [ProductRemoteDataSource] using Dio.
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
        ApiConst.products,
        queryParameters: queryParams,
      );

      // Handle API envelope: { success, message, data: { products: [...], total }, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          final data = result['data'];
          final productsList = data['products'] as List;
          final total = data['total'] as int? ?? productsList.length;

          // Calculate pagination info
          final page = pagination?.page ?? 1;
          final limit = pagination?.limit ?? 10;
          final totalPages = (total / limit).ceil();

          final products =
              productsList.map((e) => ProductModel.fromJson(e as Map<String, dynamic>)).toList();

          return PaginatedResponseModel<ProductModel>(
            data: products,
            total: total,
            page: page,
            limit: limit,
            totalPages: totalPages > 0 ? totalPages : 1,
          );
        }
        throw ServerFailure(result['message'] ?? 'Failed to fetch products');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<ProductModel> createProduct(ProductModel product) async {
    try {
      final response = await dio.post(
        ApiConst.products,
        data: {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageURL': product.imageUrl,
          'type': product.type,
          'stock': product.stock,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return ProductModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the product
        if (result.containsKey('id')) {
          return ProductModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to create product');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    try {
      final response = await dio.put(
        '${ApiConst.products}/${product.id}',
        data: {
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageURL': product.imageUrl,
          'type': product.type,
          'stock': product.stock,
        },
      );

      // Handle API envelope: { success, message, data: {...}, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] == true && result['data'] != null) {
          return ProductModel.fromJson(result['data'] as Map<String, dynamic>);
        }
        // If no data key but has id, assume result itself is the product
        if (result.containsKey('id')) {
          return ProductModel.fromJson(result);
        }
        throw ServerFailure(result['message'] ?? 'Failed to update product');
      }

      throw const ServerFailure('Invalid response format');
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    try {
      final response = await dio.delete('${ApiConst.products}/$id');

      // Handle API envelope: { success, message, data: null, error_code }
      final result = response.data;
      if (result is Map<String, dynamic>) {
        if (result['success'] != true) {
          throw ServerFailure(result['message'] ?? 'Failed to delete product');
        }
      }
      // If response is empty or success, return normally
    } on DioException catch (e) {
      throw ServerFailure(
        e.response?.data?['message'] ?? e.message ?? 'Unknown Error',
      );
    }
  }
}
