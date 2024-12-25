import 'dio_helper.dart';

abstract class ApiPackage {
  Future<List<dynamic>?> get(String path);
}

var dioPackge = DioHelper();
