class SearchModel {
  final bool status;
  final SearchData data;
  SearchModel.fromJson(Map<String, dynamic> data)
      : status = data['status'],
        data = SearchData.fromJson(data['data']);
}

class SearchData {
  List<Data> products = [];
  SearchData.fromJson(Map<String, dynamic> data) {
    for (final i in data['data']) {
      products.add(Data.fromJson(i));
    }
  }
}

class Data {
  final int id;
  final String name;
  final String image;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  Data.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        price = data['price'],
        oldPrice = data['old_price'],
        discount = data['discount'],
        name = data['name'],
        image = data['image'];
}
