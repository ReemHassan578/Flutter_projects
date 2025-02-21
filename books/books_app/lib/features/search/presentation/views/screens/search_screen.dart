import 'package:books_app/features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:books_app/features/search/presentation/views/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Column(
            children: [
              SearchTextField(),
              SearchResultListView(),
            ],
          ),
        ),
      ),
    );
  }

}
