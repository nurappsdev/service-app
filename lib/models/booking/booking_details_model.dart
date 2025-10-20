
class BookingDetailsResponseModel {
  final Details? details;
  final bool? isToday;
  final bool? checkIn;
  final bool? checkOut;

  BookingDetailsResponseModel({
    this.details,
    this.isToday,
    this.checkIn,
    this.checkOut,
  });

  factory BookingDetailsResponseModel.fromJson(Map<String, dynamic> json) => BookingDetailsResponseModel(
    details: json["details"] == null ? null : Details.fromJson(json["details"]),
    isToday: json["isToday"],
    checkIn: json["checkIn"],
    checkOut: json["checkOut"],
  );

  Map<String, dynamic> toJson() => {
    "details": details?.toJson(),
    "isToday": isToday,
    "checkIn": checkIn,
    "checkOut": checkOut,
  };
}

class Details {
  final String? client;
  final String? startTime;
  final String? endTime;
  final String? address;
  final String? image;
  final int? duration;
  final int? hourlyRate;
  final int? travelRate;
  final int? total;
  final List<String>? services;

  Details({
    this.client,
    this.startTime,
    this.endTime,
    this.address,
    this.image,
    this.duration,
    this.hourlyRate,
    this.travelRate,
    this.total,
    this.services,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
    client: json["client"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    address: json["address"],
    image: json["image"],
    duration: json["duration"],
    hourlyRate: json["hourlyRate"],
    travelRate: json["travelRate"],
    total: json["total"],
    services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "client": client,
    "startTime": startTime,
    "endTime": endTime,
    "address": address,
    "image": image,
    "duration": duration,
    "hourlyRate": hourlyRate,
    "travelRate": travelRate,
    "total": total,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
  };
}
