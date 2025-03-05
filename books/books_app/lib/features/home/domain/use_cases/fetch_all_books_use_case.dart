import 'package:books_app/core/networking/api_result.dart';
import 'package:books_app/features/home/domain/entities/book_entity.dart';
import 'package:books_app/features/home/domain/repos/home_repo.dart';

class FetchAllBooksUseCase {
  final HomeRepo homeRepo;

  FetchAllBooksUseCase({required this.homeRepo});

  Future<ApiResult<List<BookEntity>>> fetchAllBooks(int currentPage) {
   return homeRepo.getAllBooks(currentPage);
  }
}
