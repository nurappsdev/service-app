
class OpenJobDetailsResponseModel {
  final ClientDetails? clientDetails;
  final String? description;
  final Summary? summary;
  final Earnings? earnings;
  final Requirements? requirements;
  final List<String>? services;
  final bool? eligible;

  OpenJobDetailsResponseModel({
    this.clientDetails,
    this.description,
    this.summary,
    this.earnings,
    this.requirements,
    this.services,
    this.eligible
  });

  factory OpenJobDetailsResponseModel.fromJson(Map<String, dynamic> json) => OpenJobDetailsResponseModel(
    clientDetails: json["clientDetails"] == null ? null : ClientDetails.fromJson(json["clientDetails"]),
    description: json["description"],
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    earnings: json["earnings"] == null ? null : Earnings.fromJson(json["earnings"]),
    requirements: json["requirements"] == null ? null : Requirements.fromJson(json["requirements"]),
    services: json["services"] == null ? [] : List<String>.from(json["services"]!.map((x) => x)),
    eligible: json["eligible"],
  );

  Map<String, dynamic> toJson() => {
    "clientDetails": clientDetails?.toJson(),
    "description": description,
    "summary": summary?.toJson(),
    "earnings": earnings?.toJson(),
    "requirements": requirements?.toJson(),
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x)),
    "eligible": eligible,
  };
}

class ClientDetails {
  final String? name;
  final String? address;
  final String? image;

  ClientDetails({
    this.name,
    this.address,
    this.image,
  });

  factory ClientDetails.fromJson(Map<String, dynamic> json) => ClientDetails(
    name: json["name"],
    address: json["address"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "image": image,
  };
}

class Earnings {
  final int? hourlyRate;
  final int? travelRate;
  final int? total;

  Earnings({
    this.hourlyRate,
    this.travelRate,
    this.total,
  });

  factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
    hourlyRate: json["hourlyRate"],
    travelRate: json["travelRate"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "hourlyRate": hourlyRate,
    "travelRate": travelRate,
    "total": total,
  };
}

class Requirements {
  final PoliceCheck? validId;
  final PoliceCheck? policeCheck;
  final NdisWorkerCheck? ndisWorkerCheck;
  final Gender? gender;
  final Gender? qualifications;
  final Language? language;

  Requirements({
    this.validId,
    this.policeCheck,
    this.ndisWorkerCheck,
    this.gender,
    this.qualifications,
    this.language,
  });

  factory Requirements.fromJson(Map<String, dynamic> json) => Requirements(
    validId: json["valid_id"] == null ? null : PoliceCheck.fromJson(json["valid_id"]),
    policeCheck: json["police_check"] == null ? null : PoliceCheck.fromJson(json["police_check"]),
    ndisWorkerCheck: json["ndis_worker_check"] == null ? null : NdisWorkerCheck.fromJson(json["ndis_worker_check"]),
    gender: json["gender"] == null ? null : Gender.fromJson(json["gender"]),
    qualifications: json["qualifications"] == null ? null : Gender.fromJson(json["qualifications"]),
    language: json["language"] == null ? null : Language.fromJson(json["language"]),
  );

  Map<String, dynamic> toJson() => {
    "valid_id": validId?.toJson(),
    "police_check": policeCheck?.toJson(),
    "ndis_worker_check": ndisWorkerCheck?.toJson(),
    "gender": gender?.toJson(),
    "qualifications": qualifications?.toJson(),
    "language": language?.toJson(),
  };
}

class Gender {
  final String? value;
  final bool? clientValue;

  Gender({
    this.value,
    this.clientValue,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
    value: json["value"],
    clientValue: json["client_value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "client_value": clientValue,
  };
}

class Language {
  final List<String>? value;
  final bool? clientValue;

  Language({
    this.value,
    this.clientValue,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    value: json["value"] == null ? [] : List<String>.from(json["value"]!.map((x) => x)),
    clientValue: json["client_value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value == null ? [] : List<dynamic>.from(value!.map((x) => x)),
    "client_value": clientValue,
  };
}

class PoliceCheck {
  final bool? value;
  final bool? clientValue;

  PoliceCheck({
    this.value,
    this.clientValue,
  });

  factory PoliceCheck.fromJson(Map<String, dynamic> json) => PoliceCheck(
    value: json["value"],
    clientValue: json["client_value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "client_value": clientValue,
  };
}
class NdisWorkerCheck {
  final bool? value;
  final bool? clientValue;

  NdisWorkerCheck({
    this.value,
    this.clientValue,
  });

  factory NdisWorkerCheck.fromJson(Map<String, dynamic> json) => NdisWorkerCheck(
    value: json["value"],
    clientValue: json["client_value"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "client_value": clientValue,
  };
}

class Summary {
  final String? time;
  final DateTime? date;
  final String? frequency;
  final String? address;
  final int? postalCode;
  final int? duration;

  Summary({
    this.time,
    this.date,
    this.frequency,
    this.address,
    this.postalCode,
    this.duration,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    time: json["time"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    frequency: json["frequency"],
    address: json["address"],
    duration: json["duration"],
    postalCode: json["postalCode"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "date": date?.toIso8601String(),
    "frequency": frequency,
    "address": address,
    "duration": duration,
    "postalCode": postalCode,
  };
}
