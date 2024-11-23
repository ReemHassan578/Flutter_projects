class HomeModel {
  final bool status;
  final HomeDataModel data;
  HomeModel.fromJson(Map<String, dynamic> data)
      : status = data['status'],
        data = HomeDataModel.fromJson(data['data']);
}

class HomeDataModel {
  final List<BannerData> banners = [];
  final List<ProductData> products = [];
  final String ad;
  HomeDataModel.fromJson(Map<String, dynamic> data) : ad = data['ad'] {
    for (final i in data['banners']) {
      banners.add(BannerData.fromJson(i));
    }
    for (final i in data['products']) {
      products.add(ProductData.fromJson(i));
    }
  }
}

class ProductData {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final String image;
  final String name;
  final bool inFavorite;
  final bool inCart;
  ProductData.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        price = data['price'],
        oldPrice = data['old_price'],
        discount = data['discount'],
        image = data['image'],
        name = data['name'],
        inFavorite = data['in_favorites'],
        inCart = data['in_cart'];
}

class BannerData {
  final int id;
  final String image;

  BannerData.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        image = data['image'];
}
