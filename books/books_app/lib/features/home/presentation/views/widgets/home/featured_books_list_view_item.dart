import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedBooksListViewItem extends StatelessWidget {
  const FeaturedBooksListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                    alignment: AlignmentDirectional.bottomEnd,
                    width: 110.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg',
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                    child: IconButton.filled(
                        // color: Colors.white.withOpacity(0.1),
                        onPressed: () {},
                        icon: Icon(Icons.play_arrow)),
                  );
  }
}