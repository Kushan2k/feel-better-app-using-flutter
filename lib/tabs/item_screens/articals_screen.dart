import 'package:feel_better_fixed/data.dart';
import 'package:flutter/material.dart';

class ArticalsScreen extends StatefulWidget {
  const ArticalsScreen({super.key});

  @override
  State<ArticalsScreen> createState() => _ArticalsScreenState();
}

class _ArticalsScreenState extends State<ArticalsScreen> {
  bool _isLoading = true;

  List<Map<String, dynamic>> articals = [];

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        articals = Data.get_shuffled_articals();
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
            : articals.isNotEmpty
            ? ListView.builder(
                itemCount: articals.length,
                itemBuilder: (context, index) {
                  final movie = articals[index];
                  return ListTile(
                    title: Text(movie['title'] ?? 'No Title'),
                    subtitle: Text(movie['content'] ?? 'No content'),
                  );
                },
              )
            : const Text(
                'No articals available',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
      ),
    );
  }
}
