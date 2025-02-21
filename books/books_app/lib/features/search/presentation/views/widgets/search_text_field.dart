import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
                decoration: InputDecoration(
                  enabledBorder: buildOutlinedBorder(),
                  focusedBorder: buildOutlinedBorder(),
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.transparent),
                    icon: Opacity(
                      opacity: 0.8,
                      child: Icon(
                        Icons.search,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              );
  }

  
  OutlineInputBorder buildOutlinedBorder() {
    return OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.w),
                );
  }
}