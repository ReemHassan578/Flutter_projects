import 'dart:io';

import 'package:chat2/models/post_model.dart';
import 'package:chat2/modules/chats/chat_screen.dart';
import 'package:chat2/modules/feeds/feeds_screen.dart';
import 'package:chat2/modules/settings/settings_screen.dart';
import 'package:chat2/modules/users/users_screen.dart';
import 'package:chat2/shared/components/constants.dart';
import 'package:chat2/shared/cubit/states.dart';
import 'package:chat2/shared/netwok/remote/cloud_storage_helper.dart';
import 'package:chat2/shared/netwok/remote/firestore_helper.dart';
import 'package:chat2/shared/styles/icon_broken.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/user_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  int currentIndx = 0;
  List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(icon: Icon(IconBroken.Home), label: 'feeds'),
    const BottomNavigationBarItem(icon: Icon(IconBroken.Chat), label: 'chats'),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Paper_Download), label: 'post'),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Location), label: 'users'),
    const BottomNavigationBarItem(
        icon: Icon(IconBroken.Setting), label: 'settings'),
  ];
  List<Widget?> currentScreen = [
    FeedsScreen(),
    const ChatScreen(),
    null,
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> currentTitle = ['Feeds', 'Chats', '', 'Users', 'Settings'];

  final ImagePicker picker = ImagePicker();
  File? pickedProfileImage;
  File? pickedCoverImage;

  HomeCubit() : super(InitailState());

  static HomeCubit get(context) {
    return BlocProvider.of(context);
  }

  /*void testverify() {
    var acs = ActionCodeSettings(
        // URL you want to redirect back to. The domain (www.example.com) for this
        // URL must be whitelisted in the Firebase Console.
        url: 'https://localhost/www.chat2-9de03.firebaseapp.com',
        // This must be true
        handleCodeInApp: true,
        iOSBundleId: 'com.example.chattttttt',
        androidPackageName: 'com.example.chattttttt',
        // installIfNotAvailable
        androidInstallApp: true,
        // minimumVersion
        androidMinimumVersion: '12');

    FirebaseAuth.instance
        .sendSignInLinkToEmail(email: user!.email, actionCodeSettings: acs)
        .then((value) => print('Successfully sent email verification'))
        .catchError(
            (onError) => print('Error sending email verification $onError'));
  }*/

  void sendVerificationEmail() {
    emit(LoadingSendEmailVerificationState());

    FirebaseAuth.instance.currentUser!.sendEmailVerification().then(
      (value) {
        user!.verifyUser();
        FireStoreHelper.updateUserVerification(user!.uId);
        emit(SendEmailVerificationSuccessState());
      },
    ).catchError((error) {
      emit(SendEmailVerificationErrorState());
    });
  }

  UserModel? user;
  void getUserData() {
    emit(LoadingState());

    FireStoreHelper.getUser(uId!).then(
      (DocumentSnapshot value) {
        user = UserModel.fromJson(value.data() as Map<String, dynamic>);

        emit(GetUserDataSuccessState());
        getPosts();
        getUsers();
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  void changeNavBottomIndx(int indx) {
    if (indx == 2) {
      emit(AddNewPostState());
    } else {
      currentIndx = indx;
      emit(ChangeBottomNavigationBarState());
    }
  }

  Future<void> pickProfileImage() async {
    emit(LoadingState());

    picker.pickImage(source: ImageSource.camera).then(
      (value) {
        if (value == null) {
          return;
        }
        pickedProfileImage = File(value.path);
        emit(PickProfileImageSuccessState());
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  Future<void> pickCoverImage() async {
    emit(LoadingState());
    picker.pickImage(source: ImageSource.gallery).then(
      (value) {
        if (value == null) {
          return;
        }
        pickedCoverImage = File(value.path);

        emit(PickCoverImageSuccessState());
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  void updateCurrentUserInfo(
      {required String bio,
      required String phone,
      required String name,
      required String imageProfile,
      required String imageCover}) async {
    try {
      emit(LoadingUpdateState());
      if (pickedProfileImage != null &&
          user!.imageProfile != pickedProfileImage!.path) {
        await saveProfileImage(path: pickedProfileImage!.path);
      }

      if (pickedCoverImage != null &&
          user!.coverImage != pickedCoverImage!.path) {
        await saveCoverImage(path: pickedCoverImage!.path);
      }
      {
        user!.updateCurrentUserInfo(
            bio: bio,
            name: name,
            imageProfile: user!.imageProfile,
            imageCover: user!.coverImage);

        await FireStoreHelper.updateUserInfo(user: user!);
        pickedCoverImage = null;
        pickedProfileImage = null;
        emit(UpdateUserInfo());
      }
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future<void> saveProfileImage({
    required String path,
  }) async {
    try {
      var uploadedImage = await CloudStorageHelper.uploadImage(path, 'profile');
      user!.updateImageProfile(
        await uploadedImage.ref.getDownloadURL(),
      );
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  Future<void> saveCoverImage({
    required String path,
  }) async {
    try {
      var uploadedImage = await CloudStorageHelper.uploadImage(path, 'cover');
      user!.updateCoverImage(await uploadedImage.ref.getDownloadURL()
          //await CloudStorageHelper.getUploadedUrlImage(path, 'cover'),
          );
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
  }

  File? postImage;
  void choosePostImage() {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value == null) {
        return;
      } else {
        postImage = File(value.path);
        emit(ChooseImagePostSuccess());
      }
    }).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  void addPost(PostModel post) async {
    emit(LoadingState());
    try {
      if (postImage != null) {
        var uploadedImage =
            await CloudStorageHelper.uploadPostImage(postImage!.path);
        post.updatePostImage(await uploadedImage.ref.getDownloadURL());
      }
      var refPost = await FireStoreHelper.addPostToFirebase(post);
      post.updatePostuId(refPost.id);

      //await FireStoreHelper.updatePostuId(refPost.id);
      emit(PostSuccessState());
    } catch (error) {
      emit(ErrorState(error.toString()));
    }
    postImage = null;
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostSuccessState());
  }

  List<PostModel>? postsFromFireStore;

  void getPosts() async {
    var postRef = await FireStoreHelper.getPosts();

    List<PostModel> posts = [];
    for (final i in postRef.docs) {
      var info = i.data() as Map<String, dynamic>;

      Map<String, bool> likes = {};
      Map<String, Map<String, String>> comments = {};
      var likesRef = await getPostsLikes(i.id);
      var commentsRef = await getPostsComments(i.id);

      for (final j in likesRef.docs) {
        var infoLike = j.data();
        likes.addAll({j.id: infoLike['like']});
      }
      for (final j in commentsRef.docs) {
        Map<String, dynamic> infoComment = j.data();
        comments[j.id] = {};
        infoComment.forEach(
          (key, value) {
            comments[j.id]?.addAll({key: value});
          },
        );
      }
      PostModel post = PostModel.fromJson(info);
      post.updatePostuId(i.id);
      post.updateLikesInfo(likes);
      post.updateCommentsInfo(comments);

      posts.add(post);
    }

    postsFromFireStore = posts;
    emit(GetPostsSuccessState());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPostsLikes(String postuId) {
    return FireStoreHelper.getPostsLikes(postuId, user!.uId);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPostsComments(String postuId) {
    return FireStoreHelper.getPostsComments(postuId, user!.uId);
  }

  void toggleLikePost(String postuId, PostModel post) {
    FireStoreHelper.togglelikeToPost(postuId, user!.uId).then(
      (value) {
        post.updateToggleLikeInfo(uId!);
        emit(ToggleLikePostsSuccessState());
      },
    ).catchError((error) {
      emit(ErrorState(error.toString()));
    });
  }

  void addComment(String postuId, String contentPost, PostModel post) async {
    String dateComment =
        await FireStoreHelper.addCommentToFirestore(postuId, uId!, contentPost);

    post.addNewCommet(
        useruId: uId!, content: post.contentPost, date: dateComment);
    emit(AddNewCommentSuccess());
  }

  List<UserModel> users = [];

  void getUsers() {
    FireStoreHelper.getUsers().then(
      (value) {
        for (var element in value.docs) {
          users.add(UserModel.fromJson(element.data() as Map<String, dynamic>));
        }
        print(users[0].toMap());
        emit(GetUsersSuccessState());
      },
    ).catchError((error) {
      emit(ErrorState(error));
    });
  }
}
