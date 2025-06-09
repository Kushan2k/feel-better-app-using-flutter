import 'package:feel_better_fixed/data.dart';
import 'package:flutter/material.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  bool _isLoading = true;

  List<Map<String, dynamic>> songs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        songs = Data.get_shuffled_songs();
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Musics')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : songs.isNotEmpty
            ? ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  final movie = songs[index];
                  return ListTile(
                    title: Text(movie['title'] ?? 'No Title'),
                    subtitle: Text(movie['artist'] ?? 'No Artist'),
                    leading: const Icon(
                      Icons.music_note,
                      size: 40,
                      color: Colors.blue,
                    ),
                  );
                },
              )
            : const Text(
                'No songs available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
      ),
    );
  }
}
