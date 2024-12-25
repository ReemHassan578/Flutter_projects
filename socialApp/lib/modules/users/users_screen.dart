import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/user_model.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        final cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.users != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => ConditionalBuilder(
            condition: cubit.users!.isNotEmpty,
            fallback: (context) => const Center(
              child: Text('No users yet!'),
            ),
            builder: (context) => Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              height: 40.h,
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    buildUserItem(cubit.users![index], context),
                itemCount: cubit.users!.length,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildUserItem(UserModel user, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      // color: const Color(0xFFF44336),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundImage: NetworkImage(
              user.imageProfile,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        user.name,
                        style: Theme.of(context).textTheme.labelLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 5.w),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
