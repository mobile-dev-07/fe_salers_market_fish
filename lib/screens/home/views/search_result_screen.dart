import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../components/drawer_navbar.dart';
import '../../../components/filter_sheet.dart';
import '../../../components/search_screen.dart';
import '../../../constants.dart';

class SearchResultScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchResultScreenPage(),
    );
  }
}

class SearchResultScreenPage extends StatelessWidget {
  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => FilterSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      // drawer: DrawerNavbar(),
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
          IconButton(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
          IconButton(
            iconSize: 35.0,
            icon: SvgPicture.asset(
              "assets/icons/burger.svg",
              height: 35.0, // Atur tinggi SVG
              width: 35.0,  // Atur lebar SVG
              colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            onPressed: () {
              // scaffoldKey.currentState?.openDrawer();
            },
          ),
          const SizedBox(width: kDefaultPaddin / 2)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _showFilterSheet(context),
              icon: Icon(Icons.filter_list),
              label: Text("Filters"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2), // lebih kotak
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Products Result : 85",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

