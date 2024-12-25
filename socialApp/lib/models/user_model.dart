import '../shared/components/constants.dart';

class UserModel {
  final String email;
  String imageProfile;
  final String phone;
  String name;
  final String uId;
  bool isEmailVerified;
  String bio;
  String coverImage;

  UserModel({
    required this.email,
    this.imageProfile = defaultProfileImage,
    required this.phone,
    required this.name,
    required this.uId,
    this.bio = defaultBio,
    this.coverImage = defaultCoverImage,
  }) : isEmailVerified = false;
  Map<String, dynamic> toMap() {
    return {
      'username': name,
      'phone': phone,
      'email': email,
      'imageProfile': imageProfile,
      'uid': uId,
      'isEmailVerified': isEmailVerified,
      'bio': bio,
      'coverImage': coverImage,
    };
  }

  void verifyUser() {
    isEmailVerified = true;
  }

  void updateCurrentUserInfo(
      {required String bio,
      required String name,
      required String imageProfile,
      required String imageCover}) {
    updateImageProfile(imageProfile);
    _updateBio(bio);
    updateCoverImage(imageCover);
    _updateName(name);
  }

  void updateImageProfile(String image) {
    imageProfile = image;
  }

  void updateCoverImage(String image) {
    coverImage = image;
  }

  void _updateName(String name) {
    this.name = name;
  }

  void _updateBio(String bio) {
    this.bio = bio;
  }

  UserModel.fromJson(Map<String, dynamic> data)
      : email = data['email'],
        phone = data['phone'],
        name = data['username'],
        uId = data['uid'],
        imageProfile = data['imageProfile'],
        isEmailVerified = data['isEmailVerified'],
        bio = data['bio'],
        coverImage = data['coverImage'];
}

class ChatMessage {
  final String time;
  final String messageContent;
  final String uIdSender;

  ChatMessage(this.uIdSender,
      {required this.time, required this.messageContent});
}
