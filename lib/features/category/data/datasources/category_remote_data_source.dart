import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> createCategory(CategoryModel category);
  Future<CategoryModel> updateCategory(CategoryModel category);
  Future<void> deleteCategory(String id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final Dio dio;

  CategoryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get('/categories');
      return (response.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    } catch (e) {
      // Return generated dummy data on failure
      return List.generate(20, (index) {
        final id = (index + 1).toString();
        final categories = [
          'Brakes',
          'Engine Parts',
          'Oil & Fluids',
          'Filters',
          'Ignition',
          'Battery & Electrical',
          'Wipers & Accessories',
          'Cooling System',
          'Tires & Wheels',
          'Lights & Bulbs',
          'Interior Parts',
          'Exterior Parts',
          'Transmission',
          'Suspension',
          'Exhaust System',
          'Fuel System',
          'Air Conditioning',
          'Body Parts',
          'Tools & Equipment',
          'Car Care Products'
        ];

        final isActive = index % 7 != 0; // Every 7th item is inactive

        return CategoryModel(
          id: 'CAT-${id.padLeft(4, '0')}',
          name: categories[index % categories.length],
          description: 'High-quality ${categories[index % categories.length].toLowerCase()} for various vehicle models.',
          isActive: isActive,
        );
      });
    }
  }

  @override
  Future<CategoryModel> createCategory(CategoryModel category) async {
    try {
      final response = await dio.post('/categories', data: category.toJson());
      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<CategoryModel> updateCategory(CategoryModel category) async {
    try {
      final response = await dio.put(
        '/categories/${category.id}',
        data: category.toJson(),
      );
      return CategoryModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  @override
  Future<void> deleteCategory(String id) async {
    try {
      await dio.delete('/categories/$id');
    } on DioException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }
}
