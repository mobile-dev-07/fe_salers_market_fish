import 'package:flutter/material.dart';

import '../../../components/cart_item.dart';
import '../../../components/item_card_cart.dart';
import '../../ordersummary/views/order_summary_card.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      debugShowCheckedModeBanner: false,
      home: const ShoppingCartPage(),
    );
  }
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final List<CartItem> _cartItems = [
    CartItem(
      imageAsset: 'assets/images/fish_1.jpeg',
      title: 'Ikan bawal size m masih fresh\nbaru ditangkap tadi siang',
      price: 5000,
      quantity: 1,
    ),
    CartItem(
      imageAsset: 'assets/images/fish_2.jpeg',
      title: 'Ikan kerapu size m masih fresh\nbaru ditangkap tadi siang',
      price: 5000,
      quantity: 1,
    ),
  ];

  int get totalPrice => _cartItems.fold(
    0,
        (total, item) => total + item.price * item.quantity,
  );

  void _updateQuantity(int index, int delta) {
    setState(() {
      final item = _cartItems[index];
      item.quantity = (item.quantity + delta).clamp(1, 99);
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Shopping Cart',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (_) {}),
                  const Text('Fish Market', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: _cartItems.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = _cartItems[index];
                    return ItemCardCart(
                      imageAsset: item.imageAsset,
                      title: item.title,
                      price: item.price,
                      quantity: item.quantity,
                      onAdd: () => _updateQuantity(index, 1),
                      onRemove: () => _updateQuantity(index, -1),
                      onDelete: () => _removeItem(index),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rp.${totalPrice.toString()}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const OrderSummary()),
                      );
                    },
                    child: const Text('Beli',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}