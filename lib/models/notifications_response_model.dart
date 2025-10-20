
class NotificationsResponseModel {
  final String? id;
  final String? title;
  final String? msg;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NotificationsResponseModel({
    this.id,
    this.title,
    this.msg,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) => NotificationsResponseModel(
    id: json["_id"],
    title: json["title"],
    msg: json["msg"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "msg": msg,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
