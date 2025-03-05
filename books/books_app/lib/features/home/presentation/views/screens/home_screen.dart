
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/home/best_seller_list_view.dart';
import '../widgets/home/best_seller_text.dart';
import '../widgets/home/custom_app_bar.dart';
import '../widgets/home/featured_books_list_view_bloc_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(),
                  FeaturedBooksListViewBlocBuilder(),
                  BestSellerText(),
                ],
              )),
              BestSellerListView(),
            ],
          ),
        ),
      ),
    );
  }
}
