import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../product/data/models/product_model.dart';
import '../models/stock_adjustment_model.dart';

abstract class StockRemoteDataSource {
  Future<List<ProductModel>> getStockItems();
  Future<ProductModel> adjustStock(StockAdjustmentModel adjustment);
  Future<List<StockAdjustmentModel>> getStockHistory(String productId);
}

class StockRemoteDataSourceImpl implements StockRemoteDataSource {
  final Dio dio;

  StockRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ProductModel>> getStockItems() async {
    try {
      // Use the same products endpoint as product feature
      final response = await dio.get('/products');
      return (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
    } catch (e) {
      // Return generated dummy data on failure (simulating stock items)
      return List.generate(50, (index) {
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
        final type = types[index % types.length];
        final isAvailable = index % 5 != 0;

        return ProductModel(
          id: 'PROD-${id.padLeft(4, '0')}',
          name: 'Premium $type Item #$id',
          description:
              'High-quality $type replacement part for various vehicle models.',
          price: (10 + (index * 5)) % 200 + 15,
          imageUrl: '',
          type: type,
          stock: isAvailable ? (index * 7) % 100 + 5 : 0,
          isAvailable: isAvailable,
        );
      });
    }
  }

  @override
  Future<ProductModel> adjustStock(StockAdjustmentModel adjustment) async {
    try {
      // First, get the current product to calculate new stock
      final productResponse = await dio.get('/products/${adjustment.productId}');
      final currentProduct = ProductModel.fromJson(productResponse.data);

      // Calculate new stock based on adjustment type
      int newStock = currentProduct.stock;
      if (adjustment.type == 'addition') {
        newStock += adjustment.quantity;
      } else {
        newStock -= adjustment.quantity;
        if (newStock < 0) newStock = 0; // Prevent negative stock
      }

      // Update product with new stock via PUT request
      final updatedProduct = ProductModel(
        id: currentProduct.id,
        name: currentProduct.name,
        description: currentProduct.description,
        price: currentProduct.price,
        imageUrl: currentProduct.imageUrl,
        type: currentProduct.type,
        stock: newStock,
        isAvailable: currentProduct.isAvailable,
      );

      final updateResponse = await dio.put(
        '/products/${adjustment.productId}',
        data: updatedProduct.toJson(),
      );

      // Also send stock adjustment history to API (optional, if endpoint exists)
      try {
        await dio.post('/stock/adjustments', data: adjustment.toJson());
      } catch (_) {
        // Ignore if stock adjustment history endpoint doesn't exist
      }

      return ProductModel.fromJson(updateResponse.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Failed to adjust stock: ${e.message}');
    }
  }

  @override
  Future<List<StockAdjustmentModel>> getStockHistory(String productId) async {
    try {
      // Try to get stock adjustment history from API
      final response = await dio.get('/stock/adjustments/$productId');
      return (response.data as List)
          .map((e) => StockAdjustmentModel.fromJson(e))
          .toList();
    } catch (e) {
      // Return empty list on failure (endpoint might not exist yet)
      return [];
    }
  }
}
