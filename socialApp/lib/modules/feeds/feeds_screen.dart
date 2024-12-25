import '../../models/post_model.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icon_broken.dart';
import '../../shared/styles/styles.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../shared/components/constants.dart';

class FeedsScreen extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = HomeCubit.get(context);

        return SingleChildScrollView(
          child: Column(
            children: [
              Card(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                elevation: 10,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Image.network(
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.cover,
                      'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg',
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                      child: Text(
                        'communicate with friends',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              ConditionalBuilder(
                  fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                  condition: cubit.postsFromFireStore != null,
                  builder: (context) {
                    if (cubit.postsFromFireStore!.isEmpty) {
                      return const Center(child: Text('No posts added yet!'));
                    } else {
                      return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10.h,
                        ),
                        itemBuilder: (context, index) => buildPostItem(
                          context,
                          cubit.postsFromFireStore![index],
                        ),
                        itemCount: cubit.postsFromFireStore!.length,
                      );
                    }
                  })
            ],
          ),
        );
      },
    );
  }

  Widget buildPostItem(context, PostModel post) {
    return Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.r,
                  backgroundImage: NetworkImage(
                    post.imageProfile,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              post.name,
                              style: Theme.of(context).textTheme.labelLarge,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.check_circle,
                            size: 20.sp,
                            color: defaultColor,
                          )
                        ],
                      ),
                      Text(
                        post.date,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.h),
            child: Divider(
              color: Colors.grey.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.contentPost,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Container(
                        height: 20.h,
                        padding: EdgeInsetsDirectional.only(end: 2.0.w),
                        child: MaterialButton(
                          minWidth: 1.w,
                          height: 25.h,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#Software',
                            style: bodySmall.copyWith(color: defaultColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (post.postImage != '')
                  Container(
                    width: double.infinity,
                    height: 150.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          post.postImage,
                        ),
                      ),
                    ),
                    //  child: Image.network(
                    //    'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                  ),
                SizedBox(
                  height: 30.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 35.w,
                        child: IconButton(
                          iconSize: 20.sp,
                          icon: const Icon(
                            IconBroken.Heart,
                            color: Colors.red,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        '${post.getLikesNum()}',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 35,
                        child: IconButton(
                          iconSize: 20,
                          icon: const Icon(
                            IconBroken.Chat,
                            color: Colors.amber,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        '${post.getCommentsNum()} comments',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 2.w,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.4),
                ),
                SizedBox(
                  height: 30.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 10.r,
                        backgroundImage: NetworkImage(post.imageProfile),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: TextField(
                          controller: textController,
                          onSubmitted: (value) {
                            HomeCubit.get(context)
                                .addComment(post.uId!, value, post);
                            textController.clear();
                          },
                          style: Theme.of(context).textTheme.labelSmall!,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'write a comment ...',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(color: Colors.grey)),
                        ),
                      ),
                      SizedBox(
                        width: 35.w,
                        child: IconButton(
                          iconSize: 20.sp,
                          icon: Icon(
                            post.likes[uId] == true
                                ? Icons.favorite
                                : IconBroken.Heart,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            HomeCubit.get(context)
                                .toggleLikePost(post.uId!, post);
                          },
                        ),
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
