import 'package:flutter/material.dart';

class DepressedScreen extends StatefulWidget {
  final List<String> movies;
  final List<String> songs;
  final List<String> books;

  const DepressedScreen({
    super.key,
    this.movies = const [],
    this.songs = const [],
    this.books = const [],
  });

  @override
  State<DepressedScreen> createState() => _DepressedScreenState();
}

class _DepressedScreenState extends State<DepressedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Depressed Recommendations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Feeling Depressed?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your action here
              },
              child: const Text('Get Help'),
            ),
          ],
        ),
      ),
    );
  }
}
