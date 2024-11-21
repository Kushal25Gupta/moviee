import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatelessWidget {
  final MovieController controller = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Clear Search History"),
                    content: Text("Are you sure you want to clear all search history?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.clearSearchHistory();
                          Navigator.pop(context);
                        },
                        child: Text("Clear"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        scrolledUnderElevation: 0,
      ),
      body: Obx(() {
        if (controller.previousSearches.isEmpty) {
          return Center(
            child: Text(
              "No previous search results.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.previousSearches.length,
          padding: EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final movie = controller.previousSearches[index];
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
    );
  }
}
