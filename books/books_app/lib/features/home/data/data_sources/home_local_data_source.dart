import 'package:books_app/features/home/domain/entities/book_entity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/helpers/constants.dart';

class HomeLocalDataSource {
  final Box<BookEntity> openedBox;

  HomeLocalDataSource({required this.openedBox});

  Future<void> cacheAllBooks(List<BookEntity> books) async {
    await openedBox.addAll(books);
  }

  List<BookEntity> getCachedBooks(int pageNumber) {
    int startIndex = pageNumber;
    int endIndex = pageNumber + paginationMaxItems;
    int listLength = openedBox.values.length;
    print('startIndex: $startIndex, endIndex: $endIndex');
    if (startIndex >= listLength || endIndex > listLength)  {
      return [];
    }
    
    return openedBox.values.toList().sublist(startIndex, endIndex);
  }
  //10 - 12
  //startIndex=10, endIndex=20, length=12

  bool hasCachedBooks(int pageNumber) {
    List<BookEntity> pagedList = getCachedBooks(pageNumber);
    
    return pagedList.isNotEmpty;
      }
}
