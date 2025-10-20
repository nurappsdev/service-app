
class GetEarningResponseModel {
  final String? header;
  final List<Period>? periods;

  GetEarningResponseModel({
    this.header,
    this.periods,
  });

  factory GetEarningResponseModel.fromJson(Map<String, dynamic> json) => GetEarningResponseModel(
    header: json["header"],
    periods: json["periods"] == null ? [] : List<Period>.from(json["periods"]!.map((x) => Period.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "header": header,
    "periods": periods == null ? [] : List<dynamic>.from(periods!.map((x) => x.toJson())),
  };
}

class Period {
  final String? label;
  final int? amount;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;

  Period({
    this.label,
    this.amount,
    this.status,
    this.startDate,
    this.endDate,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      label: json["label"] ?? "Unknown Period", // Add a fallback value
      amount: json["amount"] ?? 0, // Default to 0 if amount is missing
      status: json["status"] ?? "Unknown", // Default to "Unknown" if status is missing
      startDate: json["startDate"] != null ? DateTime.parse(json["startDate"]) : null,
      endDate: json["endDate"] != null ? DateTime.parse(json["endDate"]) : null,
    );
  }
  Map<String, dynamic> toJson() => {
    "label": label,
    "amount": amount,
    "status": status,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
  };
}
