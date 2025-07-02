import 'package:flutter/material.dart';
import '../constants.dart';
import 'auth/domain/entities/product_entity.dart';

class ItemCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback press;

  const ItemCard({
    super.key,
    required this.product,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container untuk gambar produk
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(product.imageUrl), // Gunakan NetworkImage
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Judul produk
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              product.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: kTextLightColor,
              ),
            ),
          ),
          // Harga produk
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Rp${product.price.toStringAsFixed(0)}", // Format harga
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const TextSpan(
                  text: "/kg",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          // Stok produk (tambahan)
          Text(
            "Stok: ${product.stock} kg",
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}