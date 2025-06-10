import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/cart_item.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Summary',
      home: Scaffold(
        body: Center(
          child: OrderSummaryCard(),
        ),
      ),
    );
  }
}

class OrderSummaryCard extends StatefulWidget {
  const OrderSummaryCard({super.key});

  @override
  State<OrderSummaryCard> createState() => _OrderSummaryCardState();
}

class _OrderSummaryCardState extends State<OrderSummaryCard> {
  final List<CartItem> cartItems = [
    CartItem(imageAsset: "",title: "Product A", quantity: 1, price: 10000),
    CartItem(imageAsset: "",title: "Product B", quantity: 2, price: 10000),
  ];

  double get subtotal => cartItems.fold(
      0, (sum, item) => sum + (item.price * item.quantity));

  double get tax => 500; // Pajak tetap
  double get total => subtotal + tax;

  String formatCurrency(double value) {
    final formatter = NumberFormat.currency(
        locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Summary",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 20),
            _buildRow("Subtotal", formatCurrency(subtotal)),
            _buildRow("Pajak", formatCurrency(tax), isGrey: true),
            const Divider(height: 32),
            _buildRow("Total", formatCurrency(total)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Booking confirmed!")),
                  );
                },
                child: const Text("Booking",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String amount, {bool isGrey = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                color: isGrey ? Colors.grey[600] : Colors.black,
                fontWeight: isGrey ? FontWeight.normal : FontWeight.bold,
              )),
          Text(amount,
              style: TextStyle(
                color: isGrey ? Colors.grey[800] : Colors.black,
                fontWeight: isGrey ? FontWeight.normal : FontWeight.bold,
              )),
        ],
      ),
    );
  }
}