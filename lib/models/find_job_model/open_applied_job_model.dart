
class OpenAppliedJobResponseModel {
  String address;
  String status;
  String timeRanges;
  DateTime date;
  String frequency;
  String workType;
  String id;
  String clientImage;

  OpenAppliedJobResponseModel({
    required this.address,
    required this.status,
    required this.timeRanges,
    required this.date,
    required this.frequency,
    required this.workType,
    required this.id,
    required this.clientImage,
  });

  factory OpenAppliedJobResponseModel.fromJson(Map<String, dynamic> json) => OpenAppliedJobResponseModel(
    address: json["address"],
    status: json["status"],
    timeRanges: json["timeRanges"],
    date: DateTime.parse(json["date"]),
    frequency: json["frequency"],
    workType: json["workType"],
    id: json["id"],
    clientImage: json["client_image"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "status": status,
    "timeRanges": timeRanges,
    "date": date.toIso8601String(),
    "frequency": frequency,
    "workType": workType,
    "id": id,
    "client_image": clientImage,
  };
}
