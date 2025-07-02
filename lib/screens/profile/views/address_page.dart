import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../../components/address/data/datasources/address_remote_data_source.dart';
import '../../../components/address/data/repositories/address_repository_impl.dart';
import '../../../components/address/domain/entities/address_entity.dart';
import '../../../components/address/domain/usecases/get_addresses_usecase.dart';
import '../../../components/address/domain/usecases/add_address_usecase.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/network_info.dart';
import '../../../core/utils/constants.dart';
import '../blocs/address_bloc.dart';
import 'add_address.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = AddressRepositoryImpl(
          remoteDataSource: AddressRemoteDataSourceImpl(
            apiService: ApiService(
              baseUrl: ApiConstants.baseUrl,
              client: http.Client(),
            ),
          ),
          networkInfo: NetworkInfoImpl(Connectivity()),
        );

        return AddressBloc(
          getAddresses: GetAddresses(repository),
          addAddress: AddAddress(repository),
        )..add(LoadAddresses());
      },
      child: const _AddressPageView(),
    );
  }
}

class _AddressPageView extends StatelessWidget {
  const _AddressPageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state.status == AddressStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == AddressStatus.failure) {
            return Center(child: Text(state.errorMessage));
          } else if (state.status == AddressStatus.success) {
            return _AddressList(addresses: state.addresses);
          }
          return Container();
        },
      ),
    );
  }
}

class _AddressList extends StatefulWidget {
  final List<AddressEntity> addresses;

  const _AddressList({required this.addresses});

  @override
  State<_AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<_AddressList> {
  int selectedAddressIndex = 0;

  void _navigateToAddAddress() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddAddressPage()),
    );

    if (result == true) {
      // Refresh addresses if a new one was added
      context.read<AddressBloc>().add(LoadAddresses());
    }
  }

  void deleteAddress(int index) {
    // Implement delete functionality
  }

  void editAddress(int index) {
    // Implement edit functionality
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 8),
                ...widget.addresses.asMap().entries.map((entry) {
                  final index = entry.key;
                  final address = entry.value;
                  return Card(
                    color: selectedAddressIndex == index
                        ? Colors.grey.shade100
                        : Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: RadioListTile<int>(
                      value: index,
                      groupValue: selectedAddressIndex,
                      onChanged: (val) {
                        setState(() {
                          selectedAddressIndex = val!;
                        });
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            address.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              address.tag.isNotEmpty ? address.tag : 'ADDRESS',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(address.address, style: const TextStyle(height: 1.5)),
                          Text(address.contact),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => editAddress(index),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => deleteAddress(index),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
                const Divider(thickness: 1),
                Align(
                    alignment: Alignment.center,
                    child: TextButton.icon(
                      onPressed: _navigateToAddAddress,
                      icon: const Icon(Icons.add_circle, color: Colors.black),
                      label: const Text("Add New Address", style: TextStyle(color: Colors.black)),
                    )
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final selected = widget.addresses[selectedAddressIndex];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Selected: ${selected.title}')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Save", style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}