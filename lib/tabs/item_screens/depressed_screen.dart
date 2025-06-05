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
    print(
      'DepressedScreen: Movies: ${widget.movies.length}, Songs: ${widget.songs.length}, Books: ${widget.books.length}',
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Recommendations')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Feeling Depressed?',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Here are some recommendations to help you feel better:',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                if (widget.movies.isNotEmpty) ...[
                  const Text(
                    'Movies:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...widget.movies.map((movie) => Text(movie)),
                  const SizedBox(height: 10),
                ],
                if (widget.songs.isNotEmpty) ...[
                  const Text(
                    'Songs:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...widget.songs.map((song) => Text(song)),
                  const SizedBox(height: 10),
                ],
                if (widget.books.isNotEmpty) ...[
                  const Text(
                    'Books:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ...widget.books.map((book) => Text(book)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
