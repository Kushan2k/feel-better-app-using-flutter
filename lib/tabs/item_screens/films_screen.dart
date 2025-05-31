import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

const KEY =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZjYxN2ZhMzIzY2VhNjJhNzE1NjUyMDc1NTg2Y2ExZiIsIm5iZiI6MTY4NjQ1NTQxMC45OTUwMDAxLCJzdWIiOiI2NDg1NDQ3MmI2YzI2NDAwYzdmMTZlMjAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.pxz9I6D60716cLP_Sw9BxRvnboLmU5TFIYOScV97tT4";

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<dynamic> movies = [];

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMovies();
  }

  void fetchMovies() async {
    final String url =
        "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $KEY',
        },
      );
      if (response.statusCode == 200) {
        // Parse the response body
        final data = response.body;

        final List<dynamic> movies = jsonDecode(data)['results'];

        setState(() {
          this.movies = movies;
          isLoading = false;
        });

        print('Movies fetched successfully ===============: $movies');
      } else {
        throw Exception('Failed to load movies: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching movies: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies')),

      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : movies.isNotEmpty
            ? ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return ListTile(
                    title: Text(movie['title'] ?? 'No Title'),
                    subtitle: Text(movie['release_date'] ?? 'No Release Date'),
                    leading: movie['poster_path'] != null
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                            width: 50,
                            height: 75,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.movie),
                  );
                },
              )
            : const Text(
                'No movies available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
      ),
    );
  }
}
