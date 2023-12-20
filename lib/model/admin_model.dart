class AdminModel {
  String? userName;
  String? fullName;
  String? phoneNumber;
  String? address;
  AdminModel({
    this.userName,
    this.fullName,
    this.phoneNumber,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_name': userName,
      'full_name': fullName,
      'phone_number': phoneNumber,
      'address': address,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
  
    return AdminModel(
      userName: map['user_name'],
      fullName: map['full_name'],
      phoneNumber: map['phone_number'],
      address: map['address'],
    );
  }
}
