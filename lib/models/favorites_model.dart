class FavoritesModel {
  static final List<String> _favoriteItems = [];

  static List<String> get favoriteItems => _favoriteItems;

  static void addFavorite(String item) {
    if (!_favoriteItems.contains(item)) {
      _favoriteItems.add(item);
    }
  }

  static void removeFavorite(String item) {
    _favoriteItems.remove(item);
  }

  static bool isFavorite(String item) {
    return _favoriteItems.contains(item);
  }
}
