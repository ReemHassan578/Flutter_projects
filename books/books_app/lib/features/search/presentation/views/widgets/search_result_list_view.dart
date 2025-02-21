import 'package:books_app/features/search/presentation/views/widgets/search_result_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 8.h),
        child: ListView.separated(
          
          itemBuilder: (context, index) => SearchResultListViewItem(
            index: 1,
          ),
          separatorBuilder: (context, index) => SizedBox(
                  height: 10.h,
                ),
          itemCount: 10,
        ),
      ),
    );
  }
}
