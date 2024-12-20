import 'dart:io';

import 'package:chat2/models/user_model.dart';
import 'package:chat2/modules/chats/chat_details/cubit/states.dart';
import 'package:chat2/shared/components/constants.dart';
import 'package:chat2/shared/netwok/remote/cloud_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../shared/netwok/remote/firestore_helper.dart';

class ChatDetailsCubit extends Cubit<ChatDetailsStates> {
  ChatDetailsCubit() : super(InitailState());

  static ChatDetailsCubit get(context) {
    return BlocProvider.of(context);
  }

  void sendMessage(String senderuId, String time, String message) {
    if (message.trim().isEmpty) {
      return;
    }
    FireStoreHelper.sendMessage(senderuId, time, message);

    emit(AddMessageSuccessState());
  }

  final picker = ImagePicker();
  File? pickedImage;

  void pickImage() {
    picker.pickImage(source: ImageSource.gallery).then(
      (value) {
        if (value == null) return;
        pickedImage = File(value.path);
        emit(PickImageSuccessState());
      },
    );
  }

  Map<String, List<ChatMessage>>? chats;
  getChats(String senderuId) {
    Map<String, List<ChatMessage>> chatsTemp = {};

    FireStoreHelper.getChatsBetweensnderAndReciever(senderuId).listen(
      (data) {
        chatsTemp[senderuId] = [];
        data.data()?.forEach(
          (key, value) {
            if (key != 'senderuId') {
              chatsTemp[senderuId]!.add(ChatMessage(data.data()?['senderuId'],
                  time: key, messageContent: value));
            }
          },
        );
        chatsTemp[senderuId]!.sort(
          (a, b) {
            return a.time.compareTo(b.time);
          },
        );
        chats = chatsTemp;

        emit(GetChatsSuccessState());
      },
    );
  }

  void deletePickedImage() {
    pickedImage = null;
    emit(PickImageSuccessState());
  }

  void sendPickedImage(
    String senderuId,
    String time,
  ) async {
    var pickedImageRef =
        await CloudStorageHelper.uploadSendImage(senderuId, pickedImage!.path);
    sendMessage(senderuId, time, await pickedImageRef.ref.getDownloadURL());
    pickedImage = null;
  }
}
