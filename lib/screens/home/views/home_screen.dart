import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/categorries.dart';
import '../../../components/drawer_navbar.dart';
import '../../../components/item_card.dart';
import '../../../components/search_screen.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../cart/views/shopping_cart.dart';
import '../../details/views/details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
          // Stack(
          //   children: [
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
              // Positioned(
              //   right: 6,
              //   top: 6,
              //   child: Container(
              //     padding: const EdgeInsets.all(2),
              //     decoration: BoxDecoration(
              //       color: Colors.red,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     constraints: const BoxConstraints(
              //       minWidth: 16,
              //       minHeight: 16,
              //     ),
              //     child: const Text(
              //       '3', // ganti ini nanti dengan jumlah item dari state
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 10,
              //       ),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
          //   ],
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            // child: Text(
            //   "Women",
            //   style: Theme.of(context)
            //       .textTheme
            //       .titleLarge!
            //       .copyWith(fontWeight: FontWeight.bold),
            // ),
          ),
          const Categories(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                  product: products[index],
                  press: () =>
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        // product: products[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
