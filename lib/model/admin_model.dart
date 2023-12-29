class AdminModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? address;
  String? imageUrl;
  AdminModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.address,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'address': address,
      'image_url': imageUrl,
    };
  }

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      firstName: map['first_name'] != null ? map['first_name'] as String : null,
      lastName: map['last_name'] != null ? map['last_name'] as String : null,
      phoneNumber: map['phone_number'] != null ? map['phone_number'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      imageUrl: map['image_url'] != null ? map['image_url'] as String : null,
    );
  }


}
