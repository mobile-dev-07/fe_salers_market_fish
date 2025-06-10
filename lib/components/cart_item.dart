class CartItem {
  final String imageAsset;
  final String title;
  final int price;
  int quantity;

  CartItem({
    required this.imageAsset,
    required this.title,
    required this.price,
    this.quantity = 1,
  });
}