import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../components/address/domain/entities/address_request_entity.dart';
import '../blocs/address_bloc.dart';


class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final _formKey = GlobalKey<FormState>();
  final streetController = TextEditingController();
  final labelController = TextEditingController();
  final detailController = TextEditingController();
  final contactController = TextEditingController();

  List<dynamic> suggestions = [];
  String? addressResult;
  LatLng? latLngResult;

  Future<void> _fetchSuggestions(String query) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5');
    final response = await http.get(url, headers: {
      'User-Agent': 'FlutterApp',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        suggestions = data;
      });
    }
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required String label,
    Function(String)? onChanged,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF8E8E93),
              fontSize: 13,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E5EA)),
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state.status == AddressStatus.addSuccess) { // Periksa status addSuccess
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Address added successfully')),
          );
          Navigator.pop(context, true); // Kembali ke halaman daftar alamat
          context.read<AddressBloc>().add(LoadAddresses()); // Muat ulang daftar alamat di halaman sebelumnya
        } else if (state.status == AddressStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Add Address'),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField(
                          controller: streetController,
                          hint: "Contoh: Jalan Malioboro",
                          label: "Street names/ buildings/ housing",
                          onChanged: (val) {
                            if (val.length >= 3) {
                              _fetchSuggestions(val);
                            } else {
                              setState(() => suggestions = []);
                            }
                          },
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              streetController.clear();
                              setState(() {
                                suggestions = [];
                                latLngResult = null;
                                addressResult = null;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter street address';
                            }
                            return null;
                          },
                        ),

                        if (suggestions.isNotEmpty)
                          Container(
                            constraints: const BoxConstraints(maxHeight: 180),
                            margin: const EdgeInsets.only(top: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: ListView.builder(
                              itemCount: suggestions.length,
                              itemBuilder: (context, index) {
                                final suggestion = suggestions[index];
                                return ListTile(
                                  title: Text(suggestion['display_name'],
                                      style: const TextStyle(fontSize: 13)),
                                  onTap: () {
                                    final lat = double.parse(suggestion['lat']);
                                    final lon = double.parse(suggestion['lon']);
                                    final displayName = suggestion['display_name'];

                                    setState(() {
                                      streetController.text = displayName;
                                      suggestions = [];
                                      latLngResult = LatLng(lat, lon);
                                      addressResult = displayName;
                                    });
                                  },
                                );
                              },
                            ),
                          ),

                        const SizedBox(height: 20),
                        buildTextField(
                          controller: labelController,
                          hint: "Rumah / Kantor / lainnya",
                          label: "Label address",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter address label';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),
                        buildTextField(
                          controller: detailController,
                          hint: "Detail lokasi",
                          label: "Details address",
                        ),

                        const SizedBox(height: 20),
                        buildTextField(
                          controller: contactController,
                          hint: "08xxxxxxxx",
                          label: "Contact address",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter contact number';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Please enter valid contact number';
                            }
                            return null;
                          },
                        ),

                        if (latLngResult != null || addressResult != null) ...[
                          const SizedBox(height: 20),
                          Text(
                            "📍 Lokasi Terpilih:\n$addressResult\nLat: ${latLngResult?.latitude.toStringAsFixed(5)}, Lng: ${latLngResult?.longitude.toStringAsFixed(5)}",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],

                        const SizedBox(height: 32),
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
                              onPressed: () {
                                if (_formKey.currentState!.validate() && latLngResult != null) {
                                  final addressRequest = AddressRequestEntity(
                                    title: labelController.text,
                                    address: '${streetController.text}\n${detailController.text}',
                                    contact: contactController.text,
                                    latitude: latLngResult!.latitude,
                                    longitude: latLngResult!.longitude,
                                    active: true,
                                    tag: labelController.text,
                                  );

                                  context.read<AddressBloc>().add(AddNewAddress(addressRequest));
                                } else if (latLngResult == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Please select a location from suggestions')),
                                  );
                                }
                              },
                              child: state.status == AddressStatus.loading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
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
              ),
              if (state.status == AddressStatus.loading)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    streetController.dispose();
    labelController.dispose();
    detailController.dispose();
    contactController.dispose();
    super.dispose();
  }
}