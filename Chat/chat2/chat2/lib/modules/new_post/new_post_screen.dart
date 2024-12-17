import 'package:chat2/models/post_model.dart';
import 'package:chat2/shared/components/components.dart';
import 'package:chat2/shared/components/widgets/default_textbutton.dart';
import 'package:chat2/shared/cubit/cubit.dart';
import 'package:chat2/shared/cubit/states.dart';
import 'package:chat2/shared/styles/colors.dart';
import 'package:chat2/shared/styles/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../shared/components/constants.dart';

class NewPostScreen extends StatelessWidget {
  final TextEditingController thoughtsController = TextEditingController();

  NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is PostSuccessState) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        final cubit = HomeCubit.get(context);

        return Scaffold(
          appBar: buildDefaultAppBar(
              context: context,
              title: 'Create Post',
              actions: [
                DefaultTextButton(
                    onTap: () {
                      cubit.addPost(
                        PostModel(
                            useruId: uId!,
                            date: DateFormat.yMEd().format(DateTime.now()),
                            imageProfile: cubit.user!.imageProfile,
                            name: cubit.user!.name,
                            contentPost: thoughtsController.text),
                      );
                    },
                    text: 'Post'),
              ]),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
            child: Column(
              children: [
                if (state is LoadingState) const LinearProgressIndicator(),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25.r,
                              backgroundImage:
                                  NetworkImage(cubit.user!.imageProfile),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Expanded(
                              child: Text(
                                cubit.user!.name,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 270.h,
                          child: TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: thoughtsController,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.normal, color: grey),
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: grey),
                              border: InputBorder.none,
                              hintText:
                                  'What\'s in your mind , ${cubit.user!.name}!',
                            ),
                          ),
                        ),
                        if (cubit.postImage != null)
                          SizedBox(
                            width: double.infinity,
                            //height: 140.h,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Image.file(
                                  cubit.postImage!,
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0.w, vertical: 8.0.h),
                                  child: CircleAvatar(
                                    child: IconButton(
                                        onPressed: () {
                                          cubit.removePostImage();
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ),
                                )
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        icon: const Icon(IconBroken.Image),
                        onPressed: () {
                          cubit.choosePostImage();
                        },
                        label: Text(
                          'add photos',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '# tags',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
