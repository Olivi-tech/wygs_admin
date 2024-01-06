class UserModel {
  String? userId;
  String? email;
  String? imageUrl;
  List<String>? interests;
  String? joiningDate;
  String? lastLogin;
  String? name;
  String? phoneNumber;
  UserModel({
    this.email,
    this.imageUrl,
    this.interests,
    this.joiningDate,
    this.lastLogin,
    this.name,
    this.phoneNumber,
    this.userId,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String userId) {
    return UserModel(
      email: map['email'] as String,
      imageUrl: map['image_url'] as String,
     interests: List<String>.from(map['interests']),
      joiningDate: map['joining_date'] as String,
      lastLogin: map['last_login'] as String,
      name: map['name'] as String,
      phoneNumber: map['phone_number'] as String,
      userId: userId,
    );
  }
}
