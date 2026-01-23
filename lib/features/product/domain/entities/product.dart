import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final String type;
  final int stock;
  final bool isAvailable;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.type,
    required this.stock,
    required this.isAvailable,
  });

  @override
  List<Object?> get props => [id, name, description, price, imageUrl, type, stock, isAvailable];

  static List<Product> mockData() {
    return List.generate(
      100,
      (index) => Product(
        id: 'dummy_$index',
        name: 'Dummy Product ${index + 1}',
        description: 'This is a description for dummy product ${index + 1}',
        price: (index + 1) * 10000,
        imageUrl: 'https://via.placeholder.com/150',
        type: 'Dummy Type',
        stock: (index + 1) * 5,
        isAvailable: true,
      ),
    );
  }
}
