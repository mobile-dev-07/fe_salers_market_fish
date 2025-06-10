import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;

  final _controllers = {
    'name': TextEditingController(),
    'stock': TextEditingController(),
    'desc': TextEditingController(),
    'price': TextEditingController(),
  };

  // Dropdown value for category
  String? _selectedCategory = 'Kakap';
  final List<String> _categories = ['Kakap', 'Tongkol', 'Paus', 'Hiu'];

  // Radio value for fresh/frozen
  String _storageType = 'Fresh';

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.blueGrey),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _buildTextField(String label, String key) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        SizedBox(height: 8),
        TextFormField(
          controller: _controllers[key],
          decoration: _inputDecoration("Charlene Reed"),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Product Photo", style: GoogleFonts.poppins(fontSize: 14)),
        SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: _selectedImage == null
                ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.image_outlined, size: 40, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Select photo", style: TextStyle(color: Colors.grey)),
                ],
              ),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(_selectedImage!, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDropdownCategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Product Category", style: GoogleFonts.poppins(fontSize: 14)),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          items: _categories.map((cat) {
            return DropdownMenuItem(value: cat, child: Text(cat));
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
          decoration: _inputDecoration("Select category"),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildStorageTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Product Storage", style: GoogleFonts.poppins(fontSize: 14)),
        Row(
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text("Fresh"),
                value: "Fresh",
                groupValue: _storageType,
                onChanged: (val) => setState(() => _storageType = val!),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text("Frozen"),
                value: "Frozen",
                groupValue: _storageType,
                onChanged: (val) => setState(() => _storageType = val!),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Product", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              _buildTextField("Product Name", "name"),
              _buildImagePicker(),
              _buildDropdownCategory(),
              _buildTextField("Product Stock", "stock"),
              _buildTextField("Product Desc", "desc"),
              _buildTextField("Product Price", "price"),
              _buildStorageTypeSelector(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Submit logic here
                },
                child: Text("Save Product", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
