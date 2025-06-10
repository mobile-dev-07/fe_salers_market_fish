import 'package:flutter/material.dart';
import 'package:gudang_market_fish/screens/auth/views/sign_in_screen.dart';

void main() => runApp(SignUpApp());

class SignUpApp extends StatelessWidget {
  const SignUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create an account to get started',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                // Name field
                const Text('Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16, // opsional
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Email field
                const Text('Email Address',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16, // opsional
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    // hintText: 'name@email.com',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                // Password field
                const Text('Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16, // opsional
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Create a password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Confirm Password field
                TextFormField(
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Terms and conditions checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _agreeTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeTerms = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Wrap(
                        children: [
                          const Text('I\'ve read and agree with the '),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Terms and Conditions',
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Text(' and the '),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Privacy Policy.',
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_agreeTerms) {
                        // Lakukan proses pendaftaran di sini
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Signed up successfully!'),
                            duration: Duration(seconds: 1),
                          ),
                        ).closed.then((_) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => SignInScreen()),
                          );
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please agree to the terms.')),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
