import 'package:books_app/core/networking/api_error_model.dart';
import 'package:books_app/features/home/domain/entities/book_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_states.freezed.dart';

@freezed
abstract class HomeStates<T> with _$HomeStates<T> {
  const factory HomeStates.initial() = _Initial;
  const factory HomeStates.fetchFirstPageBooksLoading() = FetchFirstPageBooksLoading;
  const factory HomeStates.fetchCertainPageBooksLoading() = FetchCertainPageBooksLoading;

  const factory HomeStates.fetchBooksSuccessfully(
      List<BookEntity> allBooks) = FetchBooksSuccessfully;
  const factory HomeStates.fetchBooksError(ApiErrorModel error) =
      FetchBooksError;
       const factory HomeStates.fetchPaginationBooksError(ApiErrorModel error) =
      FetchPaginationBooksError;
}
