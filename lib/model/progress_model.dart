class ProgressModel {
  String? userName;
  String? completedDays;
  String? userId;

  ProgressModel({
    this.userName,
    this.completedDays,
   this.userId,
  });

  factory ProgressModel.fromMap(Map<String, dynamic> map,String? userId) {
    return ProgressModel(
      userName: map['user_name'] as String?,
      completedDays: map['completed_days'] as String?,
      userId:userId,
    );
  }
}
