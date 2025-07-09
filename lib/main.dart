import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gudang_market_fish/screens/auth/blocs/auth_bloc.dart';
import 'package:gudang_market_fish/screens/auth/views/sign_in_screen.dart';
import 'package:gudang_market_fish/screens/home/blocs/product_bloc.dart';
import 'package:gudang_market_fish/screens/home/blocs/ui_cubit.dart';
import 'package:gudang_market_fish/screens/home/views/home_screen.dart';
import 'package:gudang_market_fish/core/secure_storage.dart';
import 'package:gudang_market_fish/injection_container.dart';
import 'package:gudang_market_fish/screens/profile/blocs/address_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Initialize dependency injection
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _token;

  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  Future<void> _checkToken() async {
    final token = await SecureStorage.getToken();
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        // Pastikan ProductBloc juga diinisialisasi di sini dan bisa diakses
        BlocProvider(
          create: (context) => sl<ProductBloc>()..add(FetchProducts()),
          lazy: false,
        ),
        BlocProvider<AddressBloc>(
          create: (context) => sl<AddressBloc>()..add(LoadAddresses()),
          lazy: false, // Penting agar AddressBloc langsung diinisialisasi
        ),
        BlocProvider(create: (context) => sl<UiCubit>()),
      ],
      child: MaterialApp(
        title: 'Gudang Market Fish',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        // Tidak perlu BlocProvider.value lagi untuk ProductBloc di sini
        // karena sudah disediakan di MultiBlocProvider di atas.
        home: _token != null ? HomeScreen() : const SignInScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}