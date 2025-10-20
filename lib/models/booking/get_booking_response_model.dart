
class GetBookingResponseModel {
  final DateTime? date;
  final List<Datum>? data;

  GetBookingResponseModel({
    this.date,
    this.data,
  });

  factory GetBookingResponseModel.fromJson(Map<String, dynamic> json) => GetBookingResponseModel(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date?.toIso8601String(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  final String? id;
  final String? client;
  final String? time;
  final String? address;
  final String? image;

  Datum({
    this.id,
    this.client,
    this.time,
    this.address,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    client: json["client"],
    time: json["time"],
    address: json["address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client": client,
    "time": time,
    "address": address,
    "image": image,
  };
}
