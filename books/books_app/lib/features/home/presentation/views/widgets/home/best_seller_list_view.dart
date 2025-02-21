import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'best_seller_list_view_item.dart';

class BestSellerListView extends StatelessWidget {
  const BestSellerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
     // physics: NeverScrollableScrollPhysics(),
     // shrinkWrap: true,
        itemBuilder: (context, index) => BestSellerListViewItem(index: index,),
        separatorBuilder: (context, index) => SizedBox(
              height: 10.h,
            ),
        itemCount: 10);
  }
}