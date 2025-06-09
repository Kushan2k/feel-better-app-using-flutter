import 'dart:math';

import 'package:feel_better_fixed/data.dart';
import 'package:flutter/material.dart';

class NovelsScreen extends StatefulWidget {
  const NovelsScreen({super.key});

  @override
  State<NovelsScreen> createState() => _NovelsScreenState();
}

class _NovelsScreenState extends State<NovelsScreen> {
  bool _isLoading = true;

  List<Map<String, dynamic>> novels = [];

  @override
  void initState() {
    super.initState();
    // Simulate a network call or data fetching
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        novels = Data.get_shuffled_novels();
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novels')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : novels.isNotEmpty
              ? ListView.builder(
                  itemCount: novels.length,
                  itemBuilder: (context, index) {
                    final movie = novels[index];
                    return ListTile(
                      title: Text(movie['title'] ?? 'No Title'),
                      subtitle: Text(movie['author'] ?? 'No Author'),
                      leading: movie['cover'] != null
                          ? Image.network(
                              movie['cover'],
                              width: 50,
                              height: 75,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.book),
                    );
                  },
                )
              : const Text(
                  'No novels available',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
        ),
      ),
    );
  }
}
