
class AdminModel {
  String? userName;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  AdminModel({
    this.userName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
  });


 
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_name': userName,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'address': address,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      userName: map['user_name'] != null ? map['user_name'] as String : null,
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      phoneNumber: map['phone_number'] != null ? map['phone_number'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  
}
