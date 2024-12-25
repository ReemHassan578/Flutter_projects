import 'dart:io';
import '../../../../models/user_model.dart';
import 'states.dart';
import '../../../../shared/netwok/remote/cloud_storage_helper.dart';
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

        for (var element in data.docs) {
          chatsTemp[senderuId]!.add(ChatMessage(element.data()['senderuId'],
              time: element.data()['time'],
              messageContent: element.data()['title']));
        }

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
