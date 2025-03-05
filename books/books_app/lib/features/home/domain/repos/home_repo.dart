import '../../../../core/networking/api_result.dart';
import '../entities/book_entity.dart';

abstract class HomeRepo {
  
  Future<ApiResult<List<BookEntity>>> getAllBooks(int currentPage);
}
