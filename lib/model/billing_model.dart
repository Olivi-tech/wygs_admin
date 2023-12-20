class BillingModel {
  String? id;
  String? name;
  String? subscription;
  String? type;
  String? price;
  String? status;
  BillingModel({
    this.id,
    this.name,
    this.subscription,
    this.type,
    this.price,
    this.status,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'subscription': subscription,
      'type': type,
      'price': price,
      'status': status,
    };
  }

  factory BillingModel.fromMap(Map<String, dynamic> map) {
    return BillingModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      subscription: map['subscription'] != null ? map['subscription'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      price: map['price'] != null ? map['price'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

}
