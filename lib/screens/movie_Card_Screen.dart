import 'package:flutter/material.dart';

class MovieCardScreen extends StatefulWidget {
  final List<Map<String, dynamic>> movies;

  const MovieCardScreen({super.key, required this.movies});

  @override
  State<MovieCardScreen> createState() => _MovieCardScreenState();
}

class _MovieCardScreenState extends State<MovieCardScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SizedBox(
          height: 550,
          width: 350,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return _buildMovieCard(movie);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMovieCard(Map<String, dynamic> movie) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image with fixed height and rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                movie['imageUrl'],
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Movie Title
            Text(
              movie['title'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            // Release Date
            Text(
              'Release Date: ${movie['releaseDate']}',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            // Movie Description with constraints
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  movie['overview'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
