
class GetHomeBookingResponseModel {
  final String? id;
  DateTime? date;
  final String? client;
  final String? time;
  final String? address;
  final String? image;

  GetHomeBookingResponseModel({
    this.id,
    this.date,
    this.client,
    this.time,
    this.address,
    this.image,
  });

  factory GetHomeBookingResponseModel.fromJson(Map<String, dynamic> json) => GetHomeBookingResponseModel(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    client: json["client"],
    time: json["time"],
    address: json["address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date?.toIso8601String(),
    "client": client,
    "time": time,
    "address": address,
    "image": image,
  };
}
