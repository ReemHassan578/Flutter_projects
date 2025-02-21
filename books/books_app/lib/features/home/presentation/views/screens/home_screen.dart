import 'package:books_app/core/di/dependeny_injection.dart';
import 'package:books_app/features/home/data/repos_imp/home_repo_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/home/best_seller_list_view.dart';
import '../widgets/home/best_seller_text.dart';
import '../widgets/home/custom_app_bar.dart';
import '../widgets/home/featured_books_list_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getIt<HomeRepoImp>().getAllBooks().then(
      (value) {
        value.whenOrNull(success: (value) =>print(value) ,failure: (value) => print(value.getAllErrorMessages()),);
      },
    );
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
                  FeaturedBooksListView(),
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
