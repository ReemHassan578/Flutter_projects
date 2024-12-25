import 'package:chat2/modules/chats/chat_details/cubit/cubit.dart';
import 'package:chat2/modules/chats/chat_details/cubit/states.dart';
import 'package:chat2/shared/components/constants.dart';
import 'package:chat2/shared/styles/colors.dart';
import 'package:chat2/shared/styles/icon_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/user_model.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserModel user;
  final messageController = TextEditingController();
  ChatDetailsScreen(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatDetailsCubit, ChatDetailsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = ChatDetailsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundImage: NetworkImage(user.imageProfile),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(user.name),
              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.chats != null,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 12.h),
                child: Column(children: [
                  Expanded(
                    child: ListView.builder(
                      //  reverse: true,
                      itemCount: cubit.chats?[user.uId]?.length,
                      itemBuilder: (context, index) {
                        final messageItem = cubit.chats?[user.uId]?[index];
                        return buildMessageItem(ChatMessage(
                            messageItem!.uIdSender,
                            time: messageItem.time,
                            messageContent: messageItem.messageContent));
                      },
                    ),
                  ),
                  if (cubit.pickedImage != null)
                    SizedBox(
                      width: 160.w,
                      height: 160.h,
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(
                              cubit.pickedImage!,
                            ))),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: CircleAvatar(
                              radius: 14.r,
                              child: IconButton(
                                  iconSize: 12.sp,
                                  onPressed: () {
                                    cubit.deletePickedImage();
                                  },
                                  icon: const Icon(Icons.delete)),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.0.w,
                              ),
                              child: CircleAvatar(
                                radius: 14.r,
                                child: IconButton(
                                    iconSize: 12.sp,
                                    onPressed: () {
                                      cubit.sendPickedImage(
                                        user.uId,
                                        DateTime.now().toString(),
                                      );
                                    },
                                    icon: const Icon(Icons.send)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: messageController,
                        style: Theme.of(context).textTheme.labelMedium!,
                        decoration: InputDecoration(
                            hintText: 'type your message!',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.grey)),
                      )),
                      IconButton(
                          onPressed: () {
                            cubit.sendMessage(
                                user.uId,
                                DateTime.now().toString(),
                                messageController.text);
                            messageController.clear();
                          },
                          icon: const Icon(IconBroken.Send)),
                      IconButton(
                          onPressed: () {
                            cubit.pickImage();
                          },
                          icon: const Icon(Icons.attach_file))
                    ],
                  ),
                ]),
              );
            },
          ),
        );
      },
    );
  }

  Widget buildMessageItem(ChatMessage message) {
    if (message.uIdSender != uId) {
      return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            decoration: BoxDecoration(
                color: grey.withOpacity(0.4),
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(10.r),
                    topEnd: Radius.circular(10.r),
                    bottomEnd: Radius.circular(10.r))),
            child: Text(message.messageContent)),
      );
    } else {
      return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(0.4),
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10.r),
              topEnd: Radius.circular(10.r),
              bottomStart: Radius.circular(10.r),
            ),
          ),
          child: message.messageContent.startsWith('http')
              ? Image.network(
                  fit: BoxFit.cover,
                  message.messageContent,
                  height: 140.h,
                  width: 200.w,
                )
              : Text(message.messageContent),
        ),
      );
    }
  }
}
