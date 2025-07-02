class ProductEntity {
  final String id;
  final String title;
  final double price;
  final int stock;
  final String description;
  final int weight;
  final String imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductEntity({
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
}