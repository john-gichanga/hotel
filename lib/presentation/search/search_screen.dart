import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _searchResults = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                setState(() {
                  _isLoading = true;
                });
                _searchFirestore(_searchController.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a search term'),
                  ),
                );
              }
            },
            child: const Text('Search'),
          ),
          const SizedBox(height: 20),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _searchResults.isEmpty
                  ? const Text('No results found.')
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          var document = _searchResults[index];
                          return Card(
                            margin: const EdgeInsets.all(10.0),
                            child: ListTile(
                              title: Text(document['name']),
                              // Add other details you want to display from the document
                              subtitle: Text(document['other_field']),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }

  void _searchFirestore(String searchText) async {
    await _firestore
        .collection('users')
        .where('name', isEqualTo: searchText)
        .get()
        .then((value) {
      setState(() {
        _searchResults = value.docs;
        _isLoading = false;
      });
    });
  }
}
