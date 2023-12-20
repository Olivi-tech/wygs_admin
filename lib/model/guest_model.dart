class GuestModel {
  String name;
  String email;
  String joiningDate;
  String status;
  GuestModel({
    required this.name,
    required this.email,
    required this.joiningDate,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'joiningDate': joiningDate,
      'status': status,
    };
  }

  factory GuestModel.fromMap(Map<String, dynamic> map) {
    return GuestModel(
      name: map['name'] as String,
      email: map['email'] as String,
      joiningDate: map['joiningDate'] as String,
      status: map['status'] as String,
    );
  }
}
