import '../../shared/components/components.dart';
import '../../shared/components/widgets/default_textbutton.dart';
import '../../shared/components/widgets/default_textformfield.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatelessWidget {
  final TextEditingController bioController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomeCubit.get(context);
        phoneController.text = cubit.user!.phone;
        bioController.text = cubit.user!.bio;
        nameController.text = cubit.user!.name;
        return Scaffold(
          appBar: buildDefaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              DefaultTextButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.updateCurrentUserInfo(
                          phone: phoneController.text,
                          bio: bioController.text,
                          name: nameController.text,
                          imageCover: cubit.pickedCoverImage == null
                              ? cubit.user!.coverImage
                              : cubit.pickedCoverImage!.path,
                          imageProfile: cubit.pickedProfileImage == null
                              ? cubit.user!.imageProfile
                              : cubit.pickedProfileImage!.path);
                    }
                  },
                  text: 'Update'),
              SizedBox(
                width: 10.w,
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if (state is LoadingUpdateState)
                      const LinearProgressIndicator(),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 180.h,
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.r),
                                    topRight: Radius.circular(5.r))),
                            child: cubit.pickedCoverImage == null
                                ? Image.network(
                                    height: 120.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    cubit.pickedCoverImage == null
                                        ? cubit.user!.coverImage
                                        : cubit.pickedCoverImage!.path)
                                : Image.file(
                                    cubit.pickedCoverImage!,
                                    height: 120.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0.h, horizontal: 8.w),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15.r,
                              child: IconButton(
                                style: IconButton.styleFrom(
                                    backgroundColor:
                                        defaultColor.withOpacity(0.6)),
                                padding: EdgeInsets.zero,
                                iconSize: 15.sp,
                                onPressed: () {
                                  cubit.pickCoverImage();
                                },
                                icon: const Icon(
                                  IconBroken.Camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 170.h,
                            width: double.infinity,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4.w, vertical: 4.h),
                                      child: CircleAvatar(
                                        radius: 54.r,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          radius: 50.r,
                                          backgroundImage:
                                              cubit.pickedProfileImage == null
                                                  ? NetworkImage(
                                                      cubit.user!.imageProfile)
                                                  : FileImage(
                                                      cubit.pickedProfileImage!,
                                                    ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0.h, horizontal: 8.w),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        // foregroundColor: Colors.deepOrange,
                                        radius: 15.r,
                                        child: IconButton(
                                          style: IconButton.styleFrom(
                                              backgroundColor: defaultColor
                                                  .withOpacity(0.6)),
                                          iconSize: 15.sp,
                                          onPressed: () {
                                            cubit.pickProfileImage();
                                          },
                                          icon: const Icon(
                                            IconBroken.Camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    DefaultTextFormField(
                        type: TextInputType.name,
                        controller: nameController,
                        label: 'Name',
                        preIcon: IconBroken.User,
                        validator: (value) {
                          if (nameController.text.trim().isEmpty) {
                            return 'type your name';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    DefaultTextFormField(
                        type: TextInputType.name,
                        controller: bioController,
                        label: 'Bio',
                        preIcon: IconBroken.Info_Circle,
                        validator: (value) {
                          if (bioController.text.trim().isEmpty) {
                            return 'type your bio';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                    DefaultTextFormField(
                        type: TextInputType.phone,
                        controller: phoneController,
                        label: 'Phone',
                        preIcon: IconBroken.Call,
                        validator: (value) {
                          if (phoneController.text.trim().isEmpty) {
                            return 'type your phone number';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
