import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MovieController extends GetxController {
  var isLoading = false.obs;
  var movies = [].obs;
  var previousSearches = [].obs;

  final String apiKey = '881281c3';

  void fetchMovies(String query) async {
    if (query.isEmpty) {
      movies.clear();
      return;
    }

    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&s=$query'),
      );

      if (response.statusCode == 200) {
        final searchData = json.decode(response.body);

        if (searchData['Search'] != null) {
          movies.clear();

          List<Future<Map<String, dynamic>?>> movieFutures = searchData['Search']
              .map<Future<Map<String, dynamic>?>>((movie) async {
            try {
              final detailsResponse = await http.get(
                Uri.parse('http://www.omdbapi.com/?apikey=$apiKey&i=${movie['imdbID']}'),
              );

              if (detailsResponse.statusCode == 200) {
                final detailsData = json.decode(detailsResponse.body);

                return {
                  'Title': movie['Title'] ?? 'Unknown Title',
                  'Year': movie['Year'] ?? 'Unknown Year',
                  'Poster': (movie['Poster'] != null && movie['Poster'] != 'N/A')
                      ? movie['Poster']
                      : 'https://static.vecteezy.com/system/resources/previews/011/860/693/non_2x/its-movie-time-vector.jpg',
                  'Genre': detailsData['Genre'] ?? 'Unknown Genre',
                  'imdbRating': detailsData['imdbRating'] ?? '0.0',
                };
              }
            } catch (e) {
              print("Error fetching details for ${movie['imdbID']}: $e");
            }
            return null;
          }).toList();

          final movieDetails = await Future.wait(movieFutures);

          movies.value = movieDetails.where((movie) => movie != null).toList();
        } else {
          movies.clear();
        }
      } else {
        print("Search API error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during movie search: $e");
      Get.snackbar("Error", "Failed to fetch movies");
    } finally {
      isLoading.value = false;
    }
  }

  void addToPreviousSearches() {
    if (movies.isNotEmpty) {
      previousSearches.assignAll(movies);
    }
  }

  void clearSearchHistory() {
    previousSearches.clear();
  }
}
