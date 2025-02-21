import 'package:books_app/features/home/domain/entities/book_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeLocalDataSource {
  final Box<BookEntity> openedBox;

  HomeLocalDataSource({required this.openedBox});

  Future<void> cacheAllBooks(List<BookEntity> books) async {
    await openedBox.addAll(books);
  }

  List<BookEntity> getCachedBooks() {
    return openedBox.values.toList();
  }

  bool hasCachedBooks() => openedBox.isNotEmpty;
}
