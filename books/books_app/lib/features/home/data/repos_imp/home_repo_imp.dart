import 'package:books_app/core/networking/api_error_handler.dart';
import 'package:books_app/core/networking/api_result.dart';
import 'package:books_app/features/home/data/data_sources/home_local_data_source.dart';
import 'package:books_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:books_app/features/home/domain/entities/book_entity.dart';
import 'package:books_app/features/home/domain/repos/home_repo.dart';

class HomeRepoImp extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImp(
      {required this.homeLocalDataSource, required this.homeRemoteDataSource});

  @override
  Future<ApiResult<List<BookEntity>>> getAllBooks(int currentPage) async {
    try {
      List<BookEntity> allBooks;
      if (homeLocalDataSource.hasCachedBooks( currentPage)) {
         allBooks = homeLocalDataSource.getCachedBooks(currentPage);
        return ApiResult.success(allBooks);
      } else {
        var booksFetchResponse = await homeRemoteDataSource.getAllBooks(currentPage);
         allBooks = booksFetchResponse.mappingToBookEntity();
        homeLocalDataSource.cacheAllBooks(allBooks);
        return ApiResult.success(allBooks);
      }
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
