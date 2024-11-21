# Movie App - OMDb API Integration

This Flutter application allows users to search for movies and view their basic details (title, genre, IMDb rating, and poster) using the **OMDb API**. It includes two main screens: **Home Screen** and **Search Screen**. The app is built using **GetX** for state management and optimized for performance.

---

## Features

1. **Search Movies**:
   - Search for movies using the OMDb API's `s` (search) endpoint.
   - Fetch and display movie details such as genres and IMDb ratings using the `i` (details) endpoint.

2. **Two Main Screens**:
   - **Home Screen**:
     - Displays previously searched movies.
     - Includes a "Clear Search History" button to delete past searches.
   - **Search Screen**:
     - Allows users to search for movies dynamically.
     - Fetches detailed movie data for search results.

3. **Placeholder Image for Missing Posters**:
   - If a movie poster is unavailable, a default image is displayed:
     ![Default Placeholder](https://static.vecteezy.com/system/resources/previews/011/860/693/non_2x/its-movie-time-vector.jpg)

4. **Optimized API Calls**:
   - Parallel API requests fetch movie details efficiently.

5. **Error Handling**:
   - Handles missing data gracefully with default values.
   - Displays error messages when API requests fail.

---

## Screens

### 1. Home Screen

- Displays a list of previously searched movies.
- Each movie card shows:
  - Title
  - Genre (formatted as `Action | Comedy`)
  - IMDb Rating
  - Poster
- **Actions**:
  - **Delete Icon**: Clear all previously searched results.

---

### 2. Search Screen

- Allows users to search for movies.
- Dynamically fetches movie details as the user types.
- Displays a list of matching results, each showing:
  - Title
  - Genre (formatted as `Action | Comedy`)
  - IMDb Rating
  - Poster
- **Actions**:
  - Automatically saves search results to history when a search is completed.

---

## Folder Structure

```plaintext
lib/
├── controllers/
│   └── movie_controller.dart     # Handles API interactions and app state
├── widgets/
│   └── movie_card.dart           # UI component to display movie details
├── screens/
│   ├── home_screen.dart          # Displays previous search results
│   └── search_screen.dart        # Allows searching for movies
