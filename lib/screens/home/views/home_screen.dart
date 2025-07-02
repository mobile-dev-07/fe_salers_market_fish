import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gudang_market_fish/components/drawer_navbar.dart';
import 'package:gudang_market_fish/components/item_card.dart';
import 'package:gudang_market_fish/constants.dart';
import 'package:gudang_market_fish/screens/cart/views/shopping_cart.dart';
import 'package:gudang_market_fish/screens/details/views/details_screen.dart';

import '../../../components/categorries.dart';
import '../../../components/search_screen.dart';
import '../../auth/blocs/auth_bloc.dart';
import '../blocs/product_bloc.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.read<ProductBloc>().add(FetchProducts());
    print('[UI] Membangun HomeScreen');
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
      body: BlocConsumer<AuthBloc, AuthState>(
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              //   child: Text(
              //     'Fresh Fish Market',
              //     style: TextStyle(
              //       fontSize: 24,
              //       fontWeight: FontWeight.bold,
              //       color: Colors.blue[800],
              //     ),
              //   ),
              // ),
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
    );
  }
}