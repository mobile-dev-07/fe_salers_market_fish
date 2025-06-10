import 'package:flutter/material.dart';

class ConfirmCard extends StatelessWidget {
  final String date;
  final String imageAsset;
  final String title;
  final String category;
  final String price;
  final String status;
  final bool showButton;

  const ConfirmCard({
    Key? key,
    required this.date,
    required this.imageAsset,
    required this.title,
    required this.category,
    required this.price,
    required this.status,
    required this.showButton,
  }) : super(key: key);

  Color get statusColor {
    switch (status) {
      case "Process":
        return Colors.orange;
      case "Finish":
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top row: date & status
          Row(
            children: [
              Text(
                date,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Middle row: image & text
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageAsset,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Bottom row: price & button
          Row(
            children: [
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              if (showButton)
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
