import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../components/auth/domain/entities/product_entity.dart';
import '../../../components/drawer_navbar.dart';
import '../../../components/search_screen.dart';
import '../../../constants.dart';
import '../../cart/views/shopping_cart.dart';

class DetailsScreen extends StatelessWidget {
  final ProductEntity product;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    return Scaffold(
      key: scaffoldKey,
      drawer: DrawerNavbar(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/search.svg",
              colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          // IconButton(
          //   icon: SvgPicture.asset(
          //     "assets/icons/cart.svg",
          //     colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const ShoppingCart()),
          //     );
          //   },
          // ),
          IconButton(
            iconSize: 35.0,
            icon: SvgPicture.asset(
              "assets/icons/burger.svg",
              height: 35.0, // Atur tinggi SVG
              width: 35.0,  // Atur lebar SVG
              colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          const SizedBox(width: kDefaultPaddin / 2)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Expanded area with image and details
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // Gambar produk
                    ClipRRect(
                      // borderRadius: const BorderRadius.vertical(
                      //   top: Radius.circular(20),
                      // ),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        height: 330,
                        alignment: Alignment.center,
                        width: double.infinity,
                      ),
                    ),

                    // Container detail produk
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Harga
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'RP ',
                                  style: TextStyle(fontSize: 18),
                                ),
                                TextSpan(
                                  text: currencyFormat.format(product.price),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Label FRESH dan STOK
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFFFE176), Color(0xFFFFD740)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'FRESH',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8), // Jarak antara FRESH dan STOK
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFB2FF59), Color(0xFF76FF03)], // Hijau segar
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'STOK : ${product.stock}',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFBDBDBD), Color(0xFF9E9E9E)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Berat : ${product.weight} kg',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Judul Produk
                          Text(
                            product.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Deskripsi
                          Text(
                            product.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              height: 1.6,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // // Tombol tambah ke keranjang
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor: Colors.blue,
                          //       foregroundColor: Colors.black,
                          //       padding: const EdgeInsets.symmetric(vertical: 18),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(14),
                          //       ),
                          //     ),
                          //     onPressed: () {},
                          //     child: const Text(
                          //       'Add to cart',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.bold,
                          //         fontSize: 16,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}