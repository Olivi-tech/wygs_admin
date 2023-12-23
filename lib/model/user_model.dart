class UserModel {
  String? name;
  String? email;
  String? joiningDate;
  String? lastLogin;
  String? status;
  UserModel({
    this.name,
    this.email,
    this.joiningDate,
    this.lastLogin,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'joining_date': joiningDate,
      'last_login': lastLogin,
      'status': status,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      joiningDate:
          map['joining_date'] != null ? map['joining_date'] as String : null,
      lastLogin: map['last_login'] != null ? map['last_login'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }
}
