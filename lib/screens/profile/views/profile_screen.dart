import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreenPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProfileScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const profileImageSize = 100.0;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: profileImageSize / 2,
                  backgroundColor: Color(0xFFEFF5FF),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Color(0xFFB6D0F9),
                  ),
                ),
                Positioned(
                  right: 4,
                  bottom: 4,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF007BFF),
                      radius: 12,
                      child: Icon(
                        Icons.edit,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Lucas Scott',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'lucasScott@gmail.com',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              '087899509370',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name"),
                  const SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Charlene Reed",
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text("Phone Number"),
                  const SizedBox(height: 6),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Charlene Reed",
                      hintStyle: TextStyle(color: Colors.blueAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}