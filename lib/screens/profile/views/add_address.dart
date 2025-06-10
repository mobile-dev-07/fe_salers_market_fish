import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AddAddressPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Add Address",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1D1E20), // Warna hitam keabu-abuan
                ),
              ),
              const SizedBox(height: 24),

              // Nama jalan/gedung/perumahan
              const Text(
                "Nama jalan/gedung/perumahan",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 8),
              buildTextField(),

              const SizedBox(height: 20),

              // Label address
              const Text(
                "Label address",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 8),
              buildTextField(),

              const SizedBox(height: 20),

              // Alamat lengkap
              const Text(
                "Alamat lengkap",
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 8),
              buildTextField(),

              const Spacer(),

              Center(
                child: SizedBox(
                  width: 160,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Charlene Reed",
        hintStyle: const TextStyle(
          color: Color(0xFF8E8E93), // Warna hint abu-abu terang
          fontSize: 13,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE5E5EA)), // Warna border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF8E8E93)),
        ),
      ),
    );
  }
}