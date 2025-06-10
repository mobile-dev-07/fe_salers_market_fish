import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterSheet extends StatefulWidget {
  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  final List<String> locations = ['Denpasar', 'Gianyar', 'Klungkung', 'Karangasem'];
  List<String> selectedLocations = ['Denpasar'];
  double _minPrice = 0;
  double _maxPrice = 1000000;

  final _minController = TextEditingController();
  final _maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _minController.text = _minPrice.toInt().toString();
    _maxController.text = _maxPrice.toInt().toString();
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75, // 3/4 dari layar
      minChildSize: 0.5,       // Minimum saat sheet ditarik ke bawah
      maxChildSize: 0.95,      // Maksimum saat ditarik ke atas
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text("Filters", style: Theme.of(context).textTheme.headlineSmall),
            // const Divider(),
            const SizedBox(height: 16),
            // Price Filter
            Text("Price", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _minController,
                    decoration: const InputDecoration(
                        labelText: "From",
                        border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final parsed = double.tryParse(value) ?? 0;
                      if (parsed <= _maxPrice) {
                        setState(() {
                          _minPrice = parsed;
                        });
                      } else {
                        _minController.text = _minPrice.toInt().toString(); // revert
                      }
                    },
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: TextFormField(
                    controller: _maxController,
                    decoration: const InputDecoration(
                        labelText: "To",
                        border: OutlineInputBorder()
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      final parsed = double.tryParse(value) ?? _maxPrice;
                      if (parsed >= _minPrice) {
                        setState(() {
                          _maxPrice = parsed;
                        });
                      } else {
                        _maxController.text = _maxPrice.toInt().toString(); // revert
                      }
                    },
                  ),
                ),
              ],
            ),
            // RangeSlider(
            //   values: RangeValues(_minPrice, _maxPrice),
            //   min: 1299,
            //   max: 1299,
            //   onChanged: (RangeValues values) {
            //     setState(() {
            //       _minPrice = values.start;
            //       _maxPrice = values.end;
            //     });
            //   },
            // ),
            const SizedBox(height: 20),

            // Location Filter
            Text("Location", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 10),
            ...locations.map((loc) => CheckboxListTile(
              value: selectedLocations.contains(loc),
              title: Text(loc),
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                    selectedLocations.add(loc);
                  } else {
                    selectedLocations.remove(loc);
                  }
                });
              },
            )),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(child: Text("Apply")),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
