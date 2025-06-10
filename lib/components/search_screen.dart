import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../screens/home/views/search_result_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch() {
    String query = _searchController.text.trim();
    if (query.isNotEmpty) {
      // TODO: Handle pencarian (misalnya filter produk)
      print('Search for: $query');
      // Navigator.pop(context); // Jika ingin kembali langsung
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: kTextColor),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) {
                  if (_searchController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultScreen(),
                      ),
                    );
                  }
                },
              ),
            ),
            if (_searchController.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear, color: kTextColor),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
              ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Enter your search above",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
