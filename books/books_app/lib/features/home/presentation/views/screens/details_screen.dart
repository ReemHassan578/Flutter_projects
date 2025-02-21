import 'package:books_app/features/home/presentation/views/widgets/details/similar_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/details/book_actions.dart';
import '../widgets/details/book_image_container.dart';
import '../widgets/details/book_name_and_author_text.dart';
import '../widgets/details/custom_app_bar.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              spacing: 10.h,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(),
                BookImageContainer(),
               BookNameAndAuthorText(),
               BookActions(),

                Column(
                  spacing: 6.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'you can also like ',
                      style: TextStyle(
                       
                        fontSize: 14.sp,
                      ),
                    ),
                    SimilarBooksListView(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
