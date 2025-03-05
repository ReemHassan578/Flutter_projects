import 'package:books_app/features/home/presentation/view_models/cubit/home_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/helpers/constants.dart';
import '../../../../domain/entities/book_entity.dart';
import 'featured_books_list_view_item.dart';

class FeaturedBooksListView extends StatefulWidget {
  final List<BookEntity> allBooks;
  const FeaturedBooksListView({required this.allBooks, super.key});

  @override
  State<FeaturedBooksListView> createState() => _FeaturedBooksListViewState();
}

class _FeaturedBooksListViewState extends State<FeaturedBooksListView> {
  int nextPage = 1;
  bool requestLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 40.h),
      height: 200.h,
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          var currentPos = scrollInfo.metrics.pixels;
          var maxScrollLength = scrollInfo.metrics.maxScrollExtent;
          if (currentPos >= 0.7 * maxScrollLength && !requestLoading) {
            requestLoading = true;
             HomeCubit.get(context).fetchAllBook(nextPage * paginationMaxItems).then((_) {
              requestLoading = false;
               nextPage++;
            });
           
          }
          return true;
        },
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    width: 20.w,
                  ),
              itemCount: widget.allBooks.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  FeaturedBooksListViewItem(book: widget.allBooks[index])),
        ),
      ),
    );
  }
}
