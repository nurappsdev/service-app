// To parse this JSON data, do

class EarningHistoryResponse {
  final int? total;
  final List<History>? history;

  EarningHistoryResponse({
    this.total,
    this.history,
  });

  factory EarningHistoryResponse.fromJson(Map<String, dynamic> json) => EarningHistoryResponse(
    total: json["total"],
    history: json["history"] == null ? [] : List<History>.from(json["history"]!.map((x) => History.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "history": history == null ? [] : List<dynamic>.from(history!.map((x) => x.toJson())),
  };
}

class History {
  final int? amount;
  final DateTime? date;
  final String? client;

  History({
    this.amount,
    this.date,
    this.client,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    amount: json["amount"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    client: json["client"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "date": date?.toIso8601String(),
    "client": client,
  };
}
