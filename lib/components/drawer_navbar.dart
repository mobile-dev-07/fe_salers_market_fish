  // drawer_navbar.dart
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:gudang_market_fish/screens/auth/blocs/auth_bloc.dart';
  import 'package:gudang_market_fish/screens/auth/views/sign_in_screen.dart';
  import 'package:gudang_market_fish/screens/confirm/views/confirm_screen.dart';
  import 'package:gudang_market_fish/screens/home/views/product_form_screen.dart';
  import 'package:gudang_market_fish/screens/profile/views/profile_screen.dart';
  import 'package:gudang_market_fish/screens/home/blocs/ui_cubit.dart'; // Impor UiCubit
  import 'package:gudang_market_fish/screens/home/views/home_screen.dart';

  import '../screens/shopstatistic/views/shop_statistics_screen.dart'; // Impor HomeScreen jika ingin kembali ke home

  class DrawerNavbar extends StatelessWidget {
    const DrawerNavbar({super.key}); // Ubah ke StatelessWidget jika tidak ada state internal

    @override
    Widget build(BuildContext context) {
      return Drawer(
        child: ListView(
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
            ListTile(
              leading: Icon(Icons.shopping_bag), // Contoh untuk kembali ke produk
              title: Text('Products'),
              onTap: () {
                context.read<UiCubit>().navigateTo(UiPage.products);
                Navigator.pop(context); // Tutup drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Account'),
              onTap: () {
                // Jika ProfileScreen ingin menjadi bagian dari IndexedStack, ubah ini
                // context.read<UiCubit>().navigateTo(UiPage.profile);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.add_location),
              title: Text('My Addresses'), // Ubah judul jika perlu
              onTap: () {
                context.read<UiCubit>().navigateTo(UiPage.addresses); // Ubah state UI
                Navigator.pop(context); // Tutup drawer setelah klik
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_business),
              title: Text('Register The Product'),
              onTap: () {
                // Ini kemungkinan akan tetap menjadi rute baru
                context.read<UiCubit>().navigateTo(UiPage.registerProduct);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Booking Product'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ConfirmScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('Shop Statistics'),
              onTap: () {
                // context.read<UiCubit>().navigateTo(UiPage.shopStatistics);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ShopStatisticsScreen()),
                );
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