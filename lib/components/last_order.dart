import 'package:flutter/material.dart';

class LastOrder extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const LastOrder({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
        radius: 24,
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
      ),
    );
  }
}
