import 'package:chat2/modules/edit/edit_profile_screen.dart';
import 'package:chat2/shared/components/components.dart';
import 'package:chat2/shared/cubit/cubit.dart';
import 'package:chat2/shared/cubit/states.dart';
import 'package:chat2/shared/styles/colors.dart';
import 'package:chat2/shared/styles/icon_broken.dart';
import 'package:chat2/shared/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 180.h,
                child: Stack(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.r),
                              topRight: Radius.circular(5.r))),
                      child: Image.network(
                          height: 120.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          cubit.user!.coverImage),
                    ),
                    SizedBox(
                      height: 170.h,
                      width: double.infinity,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0.h, horizontal: 4.h),
                              child: CircleAvatar(
                                radius: 50.r,
                                backgroundImage:
                                    NetworkImage(cubit.user!.imageProfile),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    cubit.user!.name,
                    style: bodyLarge,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    cubit.user!.bio,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.grey),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                child: Row(
                  children: [
                    buildContainerItem(context, 100, 'Posts', () {}),
                    buildContainerItem(context, 265, 'Photos', () {}),
                    buildContainerItem(context, 10, 'Followers', () {}),
                    buildContainerItem(context, 64, 'Following', () {}),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.r)),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Add Photos',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: defaultColor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5.r)),
                    child: TextButton(
                      onPressed: () {
                        goToPage(page: EditProfileScreen(), context: context);
                      },
                      child: Icon(
                        IconBroken.Edit,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.h),
                child: Row(
                  children: [
                    Text(
                      'Photos',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'see all',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: defaultColor),
                        ))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildContainerItem(
      context, int num, String label, void Function() onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 65.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$num',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.grey,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
