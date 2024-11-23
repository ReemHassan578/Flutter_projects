class CategoriesModel {
  final bool status;
  final CategoriesData data;

  CategoriesModel.fromJson(Map<String, dynamic> data)
      : status = data['status'],
        data = CategoriesData.fromJson(data['data']);
}

class CategoriesData {
  final int currentPage;
  final List<CategoryData> data = [];
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;

  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  CategoriesData.fromJson(Map<String, dynamic> data)
      : currentPage = data['current_page'],
        firstPageUrl = data['first_page_url'],
        from = data['from'],
        lastPage = data['last_page'],
        lastPageUrl = data['last_page_url'],
        nextPageUrl = data['next_page_url'],
        path = data['path'],
        perPage = data['per_page'],
        prevPageUrl = data['prev_page_url'],
        to = data['to'],
        total = data['total'] {
    for (final i in data['data']) {
      this.data.add(CategoryData.fromJson(i));
    }
  }
}

class CategoryData {
  final int id;
  final String name;
  final String image;
  CategoryData.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        image = data['image'];
}
