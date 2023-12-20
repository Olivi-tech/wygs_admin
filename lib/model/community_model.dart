class CommunityModel {
  String? postBy;
  String? description;
  String? date;
  String? likes;
  String? comments;
  String? status;
  String? image;
  CommunityModel({
    this.postBy,
    this.description,
    this.date,
    this.likes,
    this.comments,
    this.status,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postBy': postBy,
      'description': description,
      'date': date,
      'likes': likes,
      'comments': comments,
      'status': status,
      'image': image,
    };
  }

  factory CommunityModel.fromMap(Map<String, dynamic> map) {
    return CommunityModel(
      postBy: map['postBy'] != null ? map['postBy'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      likes: map['likes'] != null ? map['likes'] as String : null,
      comments: map['comments'] != null ? map['comments'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
    );
  }
}
