class CommunityModel {
  num? comments;
  bool? isVideo;
  num? likes;
  String? postDate;
  String? postMessage;
  String? postUrl;
  String? postBy;
  String? userProfileUrl;
  String? userId;
  String? postId;
  CommunityModel({
    this.comments,
    this.isVideo,
    this.likes,
    this.postDate,
    this.postMessage,
    this.postUrl,
    this.postBy,
    this.userProfileUrl,
    this.userId,
    this.postId
  });

  factory CommunityModel.fromMap(Map<String, dynamic> map,String postId) {
    return CommunityModel(
      comments: map['comments'] != null ? map['comments'] as num : null,
      isVideo: map['is_video'] != null ? map['is_video'] as bool : null,
      likes: map['likes'] != null ? map['likes'] as num : null,
      postDate: map['post_date'] != null ? map['post_date'] as String : null,
      postMessage:
          map['post_message'] != null ? map['post_message'] as String : null,
      postUrl: map['post_url'] != null ? map['post_url'] as String : null,
      postBy: map['user_name'] != null ? map['user_name'] as String : null,
      userProfileUrl: map['user_profile_url'] != null
          ? map['user_profile_url'] as String
          : null,
      userId: map['user_uid'] != null ? map['user_uid'] as String : null,
      postId: postId,
    );
  }
}
