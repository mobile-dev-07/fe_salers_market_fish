import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gudang_market_fish/screens/auth/views/sign_up_screen.dart';

import '../../home/views/home_screen.dart';

void main() {
  runApp(const SignInScreen());
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fish Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const _SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _SignInScreen extends StatelessWidget {
  const _SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image Header
              Image.asset(
                'assets/fish.png',
                width: double.infinity,
                height: 320,
                fit: BoxFit.cover,
              ),

              const SizedBox(height: 20),

              // Welcome Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome !',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Email TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Password TextField
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.visibility_off),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Forgot Password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),

              // Login Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Register now
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                      child: const Text(
                        "Register now",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),

              const Divider(thickness: 1, indent: 24, endIndent: 24),

              const SizedBox(height: 12),

              const Text("Or continue with"),

              const SizedBox(height: 12),

              // Google Sign In
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Image.asset(
                      'assets/google_logo.png',
                      width: 20,
                    ),
                    label: const Text("Or sign in with Google"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
