// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProgressModel {
  String? name;
  String? email;
  String? joiningDate;
  String? lastLogin;
  String? progress;
  String? status;
  ProgressModel({
    this.name,
    this.email,
    this.joiningDate,
    this.lastLogin,
    this.progress,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'joiningDate': joiningDate,
      'lastLogin': lastLogin,
      'progress': progress,
      'status': status,
    };
  }

  factory ProgressModel.fromMap(Map<String, dynamic> map) {
    return ProgressModel(
      name: map['name'] as String,
      email: map['email'] as String,
      joiningDate: map['joiningDate'] as String,
      lastLogin: map['lastLogin'] as String,
      progress: map['progress'] as String,
      status: map['status'] as String,
    );
  }
}
