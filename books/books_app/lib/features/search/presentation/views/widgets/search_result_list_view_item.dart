import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../home/presentation/views/widgets/book_rating.dart';

class SearchResultListViewItem extends StatelessWidget {
  const SearchResultListViewItem({super.key, required this.index});

  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(Routes.homeScreen),
      child: SizedBox(
        height: 140.h,
        child: Row(
          spacing: 20.w,
          children: [
            Container(
              width: 100.w,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w),
              ),
              //width: 160.w,
              child: Image.network(
                'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      'namecvbnbvcvbnbvvcvbnbvbnbvbvbnbvbnmn',
                      style: TextStyles.font20WhiteRegular.copyWith(
                          fontFamily: TextStyles.gTSectraFineRegularFont),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'author',
                    style: TextStyles.font14greyRegular,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1414 \$',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.font20WhiteBold),
                      Expanded(
                          child: BookRating(
                              mainAxisAlignment: MainAxisAlignment.end))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
