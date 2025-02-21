import 'package:books_app/features/home/presentation/views/widgets/details/similar_books_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                      height: 140.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => SimilarBooksListViewItem(),
                        itemCount: 10,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 4.w,
                        ),
                      ),
    );
  }
}