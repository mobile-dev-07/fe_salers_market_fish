import 'package:flutter/material.dart';

import '../../auth/views/sign_in_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // // Skip button
            // Positioned(
            //   top: 20,
            //   right: 20,
            //   child: Row(
            //     children: [
            //       TextButton(
            //         onPressed: () {
            //           // Aksi skip
            //         },
            //         child: Text(
            //           'Skip',
            //           style: TextStyle(
            //             color: Colors.blue,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //       CircleAvatar(
            //         radius: 18,
            //         backgroundColor: Colors.blue,
            //         child: Icon(Icons.arrow_forward, color: Colors.white, size: 18),
            //       ),
            //     ],
            //   ),
            // ),

            // Konten utama
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gambar
                Image.asset(
                  'assets/onboarding2.jpg',
                  height: 300,
                ),
                const SizedBox(height: 24),

                // Indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 6,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Judul
                Text(
                  'Open Your Store Today!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 12),

                // Deskripsi
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Get discovered. Start selling to a global audience today!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[600],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Tombol bawah
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.arrow_forward, color: Colors.white, size: 26),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
