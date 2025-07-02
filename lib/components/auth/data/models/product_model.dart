import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String title;
  final double price;
  final int stock;
  final String description;
  final int weight;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    required this.description,
    required this.weight,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      stock: json['stock'],
      description: json['description'],
      weight: json['weight'],
      imageUrl: json['image_url'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updated_at'] * 1000),
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      stock: stock,
      description: description,
      weight: weight,
      imageUrl: imageUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}