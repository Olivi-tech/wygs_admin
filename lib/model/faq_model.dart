class FaqModel {
  Map<String, dynamic> faq = {};

  FaqModel({
    required this.faq,
  });

  factory FaqModel.fromMap(Map<String, dynamic> map) {
    return FaqModel(
      faq: map['faq'] as Map<String, dynamic>,
    );
  }
}