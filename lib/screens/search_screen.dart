import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MovieController controller = Get.find<MovieController>();
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.clear();
    controller.movies.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Screen",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  controller.fetchMovies(value);
                }
              },
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.addToPreviousSearches();
                }
              },
              decoration: InputDecoration(
                hintText: 'Search Movies',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (controller.movies.isEmpty) {
                return Center(
                  child: Text(
                    "No results found.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.movies.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final movie = controller.movies[index];
                  return MovieCard(
                    imageUrl: movie['Poster'] != 'N/A'
                        ? movie['Poster']
                        : 'https://www.vecteezy.com/free-vector/movie-time',
                    title: movie['Title'] ?? 'Unknown Title',
                    genres: movie['Genre'] ?? 'Unknown Genre',
                    rating: double.tryParse(movie['imdbRating'] ?? '0') ?? 0.0,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
