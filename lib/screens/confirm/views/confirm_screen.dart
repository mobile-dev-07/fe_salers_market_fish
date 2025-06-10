import 'package:flutter/material.dart';

import '../../../components/confirm_card.dart';

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ConfirmCard(
            date: "9 Juni 2025",
            imageAsset: "assets/images/fish_1.jpeg",
            title: "Ikan Kerapu size xl ditangkap pagi ini masih fresh di pasar seharga 200000",
            category: "kerapu",
            price: "Rp100.000",
            status: "Process",
            showButton: true,
          ),
          ConfirmCard(
            date: "9 Juni 2025",
            imageAsset: "assets/images/fish_2.jpeg",
            title: "Ikan Kerapu size xl ditangkap pagi ini masi...",
            category: "kerapu",
            price: "Rp100.000",
            status: "Finish",
            showButton: false,
          ),
        ],
      ),
    );
  }
}
