import '../../../models/post_model.dart';
import '../../../models/user_model.dart';
import '../../components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference users = _firestore.collection('users');
  static final CollectionReference posts = _firestore.collection('posts');

  static Future<void> addUser(UserModel user) {
    return users.doc(user.uId).set(user.toMap());
  }

  static Future<DocumentSnapshot<Object?>> getUser(String uId) {
    return users.doc(uId).get();
  }

  static Future<void> updateUserVerification(String uId) async {
    users.doc(uId).set({'isEmailVerified': true}, SetOptions(merge: true));
  }

  static Future<void> updateUserInfo({required UserModel user}) async {
    users.doc(uId).set(user.toMap(), SetOptions(merge: true));
  }

  static Future<DocumentReference<Object?>> addPostToFirebase(
      PostModel post) async {
    return posts.add(post.toMap());
  }

  static Future<QuerySnapshot<Object?>> getPosts() {
    return posts.get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getPostsLikes(
      String postuId, String useruId) {
    return posts.doc(postuId).collection('likes').get();
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getPostsComments(
      String postuId, String useruId) {
    return posts.doc(postuId).collection('comments').get();
  }

  static Future<void> togglelikeToPost(String postuId, String useruId) async {
    bool? isLiked = await getIsPostLiked(postuId, useruId);
    return posts.doc(postuId).collection('likes').doc(useruId).set(
        {'like': isLiked == null ? true : !isLiked}, SetOptions(merge: true));
  }

  static Future<bool?> getIsPostLiked(String postuId, String useruId) async {
    var postInfo =
        await posts.doc(postuId).collection('likes').doc(useruId).get();
    return postInfo.data()?['like'];
  }

  static Future<String> addCommentToFirestore(
      String postuId, String useruId, String postContent) async {
    String date = DateTime.now().toString();
    posts
        .doc(postuId)
        .collection('comments')
        .doc(useruId)
        .set({date: postContent}, SetOptions(merge: true));
    return date;
  }

  static Future<QuerySnapshot<Object?>> getUsers() {
    return users.get();
  }

  static void sendMessage(String senderuId, String time, String message) {
    users
        .doc(uId)
        .collection('chats')
        .doc(senderuId)
        .collection(senderuId)
        .add({'title': message, 'time': time, 'senderuId': uId});
    users.doc(senderuId).collection('chats').doc(uId).collection(uId!).add(
      {'title': message, 'time': time, 'senderuId': uId},
    );
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getChatsBetweensnderAndReciever(String senderuId) {
    return users
        .doc(uId)
        .collection('chats')
        .doc(senderuId)
        .collection(senderuId)
        .orderBy('time', descending: false)
        .snapshots();
  }
}
