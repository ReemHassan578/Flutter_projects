class FavoritesModel {
  final FavoritesData data;
  FavoritesModel.fromJson(Map<String, dynamic> data)
      : data = FavoritesData.fromJson(data['data']);
}

class FavoritesData {
  final int currentPage;
  final List<FavoriteData> favorites = [];

  FavoritesData.fromJson(Map<String, dynamic> data)
      : currentPage = data['current_page'] {
    for (final i in data['data']) {
      favorites.add(FavoriteData.fromJson(i));
    }
  }
}

class FavoriteData {
  final int id;
  final FavoriteProductData data;
  FavoriteData.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        data = FavoriteProductData.fromJson(data['product']);
}

class FavoriteProductData {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;

  FavoriteProductData.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        price = data['price'],
        oldPrice = data['old_price'],
        discount = data['discount'],
        image = data['image'],
        name = data['name'];
}
