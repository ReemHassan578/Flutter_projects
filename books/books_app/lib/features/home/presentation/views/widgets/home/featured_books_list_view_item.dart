import 'package:books_app/features/home/domain/entities/book_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedBooksListViewItem extends StatelessWidget {
  final BookEntity book;
  const FeaturedBooksListViewItem({required this.book ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.bottomEnd,
      width: 110.w,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: CachedNetworkImageProvider(
book.image,            ),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: IconButton.filled(
          // color: Colors.white.withOpacity(0.1),
          onPressed: () {},
          icon: Icon(Icons.play_arrow)),
    );
  }
}
