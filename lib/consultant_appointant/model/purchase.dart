class PurchaseModel {
  final String? id;
  final String dateTime;
  final String timeOfDay;
  final String address;
  final String username;
  final String phone;
  final String expertId;
  final String userId;

  PurchaseModel({
    this.id,
    required this.dateTime,
    required this.timeOfDay,
    required this.address,
    required this.username,
    required this.phone,
    required this.expertId,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        "date": dateTime,
        "time": timeOfDay,
        "address": address,
        "username": username,
        "phone": phone,
        "expertId": expertId,
        "userId": userId,
      };

  factory PurchaseModel.fromJson(Map<String, dynamic> data, String id) =>
      PurchaseModel(
        id: id,
        dateTime: data['date'] as String,
        timeOfDay: data['time'] as String,
        address: data['address'] as String,
        username: data['username'] as String,
        phone: data['phone'] as String,
        expertId: data['expertId'] as String,
        userId: data['userId'] as String,
      );
}
