import 'package:books_app/features/home/domain/entities/book_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'items_model.dart';
part 'books_fetch_response_model.g.dart';

@JsonSerializable()
class BooksFetchResponse {
  final String kind;
  final int totalItems;
  final List<Items> items;

  BooksFetchResponse(
      {required this.kind, required this.totalItems, required this.items});

  factory BooksFetchResponse.fromJson(Map<String, dynamic> json) =>
      _$BooksFetchResponseFromJson(json);

  List<BookEntity> mappingToBookEntity() {
    var bookEntities = items
        .map(
          (book) => BookEntity(book.id,
              image: book.volumeInfo.imageLinks.smallThumbnail,
              title: book.volumeInfo.title,
              authorName: book.volumeInfo.authors[0],
              price: book.saleInfo.listPrice?.amount,
              rating: 2.4),
        )
        .toList();
    return bookEntities;
  }
}
