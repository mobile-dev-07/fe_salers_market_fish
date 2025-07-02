import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gudang_market_fish/screens/profile/views/add_address.dart';

import '../screens/auth/blocs/auth_bloc.dart';
import '../screens/auth/views/sign_in_screen.dart';
import '../screens/confirm/views/confirm_screen.dart';
import '../screens/product/views/product_form_screen.dart';
import '../screens/profile/views/profile_screen.dart';
import '../screens/profile/views/address_page.dart';
import '../screens/shopstatistic/views/shop_statistics_screen.dart';

class DrawerNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Oflutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.favorite),
          //   title: Text('Favorites'),
          //   onTap: () => null,
          // ),
          // ListTile(
          //   leading: Icon(Icons.share),
          //   title: Text('Share'),
          //   onTap: () => null,
          // ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Account'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),

          ListTile(
            leading: Icon(Icons.add_location),
            title: Text('Add address'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AddressPage()),
              )
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add_business),
            title: Text('Register The Product'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductFormScreen()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Booking Product'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ConfirmScreen()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop Statistics'),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ShopStatisticsScreen()),
              )
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}