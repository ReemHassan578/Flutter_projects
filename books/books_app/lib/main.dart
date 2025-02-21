import 'package:books_app/books_app.dart';
import 'package:books_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/di/dependeny_injection.dart';
import 'core/helpers/constants.dart';
import 'features/home/domain/entities/book_entity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await initHive();
  await ScreenUtil.ensureScreenSize();
  setupGetIt();
  runApp(BooksApp(
    router: AppRouter(),
  ));
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  await Hive.openBox<BookEntity>(booksBox);
}
