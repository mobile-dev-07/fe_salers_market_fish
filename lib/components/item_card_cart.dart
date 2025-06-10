import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCardCart extends StatelessWidget {
  final String imageAsset;
  final String title;
  final int price;
  final int quantity;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onDelete;

  const ItemCardCart({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imageAsset,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.remove),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(quantity.toString()),
                  ),
                  IconButton(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add),
                  ),
                  const Spacer(),
                  Text('Rp.$price',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
