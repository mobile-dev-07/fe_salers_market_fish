import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/product.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.product, required this.press});

  final Product product;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Ukuran gambar yang seragam: rasio 1:1 (square)
          Container(
            height: 150, // ukuran tinggi gambar
            width: double.infinity, // agar lebarnya penuh sesuai grid
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage(product.image),
                fit: BoxFit.cover, // gambar memenuhi area (crop jika perlu)
              ),
            ),
          ),
          const SizedBox(height: 8),
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
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "\Rp${product.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "/kg",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
