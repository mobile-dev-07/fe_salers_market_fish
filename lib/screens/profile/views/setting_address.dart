import 'package:flutter/material.dart';
import 'add_address.dart';

void main() => runApp(SettingAddress());

class SettingAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingAddressPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Address {
  final String title;
  final String type;
  final String address;
  final String phone;

  Address(this.title, this.type, this.address, this.phone);
}

class SettingAddressPage extends StatefulWidget {
  @override
  _SettingAddressPageState createState() => _SettingAddressPageState();
}

class _SettingAddressPageState extends State<SettingAddressPage> {
  int selectedAddressIndex = 0;

  final List<Address> addresses = [
    Address('2118 Thornridge', 'HOME', '2118 Thornridge Cir.\nSyracuse, Connecticut 35624', '(209) 555-0104'),
    Address('Headoffice', 'OFFICE', '2715 Ash Dr. San Jose,\nSouth Dakota 83475', '(704) 555-0127'),
  ];

  void addAddress() {
    // Placeholder for "Add New Address" functionality
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Add New Address clicked')));
  }

  void deleteAddress(int index) {
    setState(() {
      addresses.removeAt(index);
      if (selectedAddressIndex >= addresses.length) {
        selectedAddressIndex = addresses.length - 1;
      }
    });
  }

  void editAddress(int index) {
    // Placeholder for edit functionality
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Edit Address: ${addresses[index].title}')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Select Address', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Select Address',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),


            ...List.generate(addresses.length, (index) {
              final address = addresses[index];
              return Card(
                color: selectedAddressIndex == index ? Colors.grey.shade100 : Colors.white,
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
                      Text(address.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          address.type,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(address.address, style: TextStyle(height: 1.5)),
                      Text(address.phone),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => editAddress(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => deleteAddress(index),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
            Divider(thickness: 1),
            TextButton.icon(
              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddAddress()),
                  );
                },
              icon: Icon(Icons.add_circle, color: Colors.black),
              label: Text("Add New Address", style: TextStyle(color: Colors.black)),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final selected = addresses[selectedAddressIndex];
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: ${selected.title}')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text("Save", style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
