class PostModel {
  String? uId;
  final String imageProfile;
  final String name;
  final String contentPost;
  final String date;
  String postImage;
  Map<String, bool> likes = {};
  Map<String, List<Comment>> comments = {};
  final String useruId;

  PostModel(
      {required this.useruId,
      this.postImage = '',
      required this.date,
      required this.imageProfile,
      required this.name,
      required this.contentPost});

  PostModel.fromJson(Map<String, dynamic> json)
      : useruId = json['useruId'],
        postImage = json['postImage'],
        date = json['date'],
        imageProfile = json['imageProfile'],
        name = json['name'],
        contentPost = json['contentPost'];

  Map<String, dynamic> toMap() {
    return {
      'useruId': useruId,
      'imageProfile': imageProfile,
      'name': name,
      'contentPost': contentPost,
      'date': date,
      'postImage': postImage,
    };
  }

  void updatePostImage(String postImage) {
    this.postImage = postImage;
  }

  void updatePostuId(String uId) {
    this.uId = uId;
  }

  void updateLikesInfo(Map<String, bool> dataLikes) {
    likes = dataLikes;
  }

  void updateCommentsInfo(Map<String, List<Comment>> dataComments) {
    comments = dataComments;
  }

  int getLikesNum() {
    return likes.entries
        .where(
          (element) => element.value == true,
        )
        .toList()
        .length;
  }

  int getCommentsNum() {
    int commentsNum = 0;
    for (var element in comments.entries) {
      commentsNum += element.value.length;
    }
    return commentsNum;
  }

  void updateToggleLikeInfo(String useruId) {
    if (likes.containsKey(useruId)) {
      likes[useruId] = !(likes[useruId]!);
    } else {
      likes[useruId] = true;
    }
  }

  void addNewCommet(
      {required String useruId,
      required String content,
      required String date}) {
    if (comments.containsKey(useruId)) {
      comments[useruId]?.add(Comment(time: date, commentContent: content));
    } else {
      comments[useruId] = [Comment(time: date, commentContent: content)];
    }
  }
}

class Comment {
  final String time;
  final String commentContent;

  Comment({required this.time, required this.commentContent});
}
