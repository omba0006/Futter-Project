
import 'package:flutter/material.dart';
import '../utils/http_helper.dart';

class MovieChoicesScreen extends StatefulWidget {
  const MovieChoicesScreen({super.key});

  @override
  State<MovieChoicesScreen> createState() => _MovieChoicesScreenState();
}

class _MovieChoicesScreenState extends State<MovieChoicesScreen> {
  final HttpHelper httpHelper = HttpHelper();
  List<dynamic> movies = [];
  bool isLoading = true;
  int currentIndex = 0;
  int rightSwipeCount = 0;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      final fetchedMovies = await httpHelper.fetchPopularMovies();
      setState(() {
        movies = fetchedMovies;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint('Error fetching movies: $e');
    }
  }

  void handleSwipe(DismissDirection direction) {
    if (direction == DismissDirection.startToEnd) {
      rightSwipeCount++;
    }

    if (rightSwipeCount == 2) {
      showWinnerCard();
      return;
    }

    if (currentIndex < movies.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      setState(() {
        currentIndex = 0; 
        rightSwipeCount = 0; 
      });
    }
  }

  void showWinnerCard() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final winningMovie = movies[currentIndex];
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            '${winningMovie['title']} - Winner!',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (winningMovie['poster_path'] != null)
                Image.network(
                  'https://image.tmdb.org/t/p/w500${winningMovie['poster_path']}',
                  height: 300,
                ),
              const SizedBox(height: 16),
              Text(
                '${winningMovie['title']} - is the Matching movie!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  rightSwipeCount = 0;
                  currentIndex = 0;
                });
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Choices'),
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : movies.isEmpty
              ? const Center(child: Text('No movies available.'))
              : Center(
                  child: SizedBox(
                    height: 500,
                    width: 350,
                    child: Dismissible(
                      key: ValueKey(movies[currentIndex]['id']),
                      direction: DismissDirection.horizontal,
                      onDismissed: handleSwipe,
                      background: swipeBackground(true),
                      secondaryBackground: swipeBackground(false),
                      child: MovieCard(movie: movies[currentIndex]),
                    ),
                  ),
                ),
    );
  }

  Widget swipeBackground(bool isRightSwipe) {
    return Container(
      color: isRightSwipe ? Colors.green : Colors.red,
      alignment: isRightSwipe ? Alignment.centerLeft : Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(
        isRightSwipe ? Icons.thumb_up : Icons.thumb_down,
        color: Colors.white,
        size: 50,
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final dynamic movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (movie['poster_path'] != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 20),
          Text(
            movie['title'] ?? 'Unknown Title',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Release Date: ${movie['release_date'] ?? 'Unknown'}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              movie['overview'] ?? 'No description available.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
