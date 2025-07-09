import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gudang_market_fish/components/drawer_navbar.dart';
import 'package:gudang_market_fish/components/item_card.dart';
import 'package:gudang_market_fish/constants.dart';
import 'package:gudang_market_fish/screens/cart/views/shopping_cart.dart';
import 'package:gudang_market_fish/screens/details/views/details_screen.dart';
import 'package:gudang_market_fish/screens/home/views/product_form_screen.dart';

import '../../../components/categorries.dart';
import '../../../components/search_screen.dart';
import '../../auth/blocs/auth_bloc.dart';
import '../../profile/views/profile_screen.dart';
import '../../shopstatistic/views/shop_statistics_screen.dart';
import '../blocs/product_bloc.dart';

// Import necessary files for AddressPage and UiCubit
import 'package:gudang_market_fish/screens/profile/views/address_page.dart'; // Import AddressPage
import 'package:gudang_market_fish/screens/profile/blocs/address_bloc.dart'; // Import AddressBloc for its BlocProvider.value
import 'package:gudang_market_fish/screens/home/blocs/ui_cubit.dart'; // Import UiCubit and UiPage

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // This line might need to be moved or re-evaluated depending on when you want products to load.
    // If ProductBloc is lazily loaded and you want products to show immediately on home screen,
    // ensure `lazy: false` in MultiBlocProvider or keep this.
    // context.read<ProductBloc>().add(FetchProducts()); // You might remove this if using UiCubit to decide initial page
    print('[UI] Membangun HomeScreen');

    // The AppBar actions might need to be dynamic based on the current page.
    // For now, we'll keep them static as per your code.
    return Scaffold(
      key: scaffoldKey,
      // You might need to pass the current UiPage or UiCubit directly to DrawerNavbar
      // if it needs to highlight the active menu item.
      drawer: const DrawerNavbar(), // Ensure DrawerNavbar is const if possible
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back.svg"),
          onPressed: () {
            final currentUiPage = context.read<UiCubit>().state.currentPage;

            if (currentUiPage == UiPage.addresses || currentUiPage == UiPage.registerProduct) {
              // Jika sedang di halaman alamat, kembali ke halaman produk
              context.read<UiCubit>().navigateTo(UiPage.products);
            } else {
              // Jika sudah di halaman produk (atau halaman lain yang merupakan bagian dari IndexedStack)
              // dan ini adalah AppBar utama, Anda mungkin ingin mempop rute sebelumnya,
              // atau biarkan tombol ini tidak berfungsi jika tidak ada rute sebelumnya.
              // Jika HomeScreen adalah halaman utama setelah login, pop mungkin tidak efektif.
              // Jika ada halaman lain sebelum HomeScreen, barulah pop akan berfungsi.
              // Navigator.pop(context); // Atau biarkan kosong jika ini halaman utama
            }
          }, // This usually implies going back in navigation stack, consider context.pop()
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
            iconSize: 35.0,
            icon: SvgPicture.asset(
              "assets/icons/burger.svg",
              height: 35.0,
              width: 35.0,
              colorFilter: const ColorFilter.mode(kTextColor, BlendMode.srcIn),
            ),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
          ),
          const SizedBox(width: kDefaultPaddin / 2)
        ],
      ),
      // --- THIS IS THE MAIN SECTION TO CHANGE ---
      body: BlocBuilder<UiCubit, UiState>( // Listen to UiCubit for UI page changes
        builder: (context, uiState) {
          // Based on the current page from UiCubit, display the corresponding content
          return IndexedStack(
            index: uiState.currentPage.index, // Use the index of the current UiPage enum
            children: [
              // 0: Product List Page (original content of your HomeScreen body)
              BlocConsumer<AuthBloc, AuthState>( // Wrap product view with AuthBlocConsumer as before
                listener: (context, authState) {
                  if (authState is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(authState.message)),
                    );
                  }
                },
                builder: (context, authState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                        child: authState is AuthSuccess
                            ? Text(
                          'Welcome, ${authState.authEntity.name}!',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 10),
                      const Categories(),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
                          child: BlocBuilder<ProductBloc, ProductState>(
                            builder: (context, state) {
                              print('[UI] Current ProductState: ${state.runtimeType}');
                              if (state is ProductLoading) {
                                return const Center(child: CircularProgressIndicator());
                              } else if (state is ProductError) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(state.message),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<ProductBloc>().add(FetchProducts());
                                        },
                                        child: const Text('Retry'),
                                      ),
                                    ],
                                  ),
                                );
                              } else if (state is ProductLoaded) {
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    context.read<ProductBloc>().add(FetchProducts());
                                  },
                                  child: GridView.builder(
                                    itemCount: state.products.length,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: kDefaultPaddin,
                                      crossAxisSpacing: kDefaultPaddin,
                                      childAspectRatio: 0.75,
                                    ),
                                    itemBuilder: (context, index) => ItemCard(
                                      product: state.products[index],
                                      press: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsScreen(
                                            product: state.products[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              // 1: Address Page
              // Ensure AddressBloc is provided to AddressPage
              BlocProvider.value(
                value: context.read<AddressBloc>(), // Use the existing AddressBloc
                child: const AddressPage(), // Your AddressPage widget
              ),

              ProfileScreen(),
              ShopStatisticsScreen(),
              ProductFormScreen(),
              // You can add more pages here corresponding to UiPage enum values
              // for example:
              // BlocProvider.value(
              //   value: context.read<ProfileBloc>(),
              //   child: const ProfileScreen(),
              // ),
            ],
          );
        },
      ),
    );
  }
}