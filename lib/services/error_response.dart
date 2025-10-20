
class ErrorResponse {
  final dynamic status;
  final dynamic statusCode;
  final dynamic message;

  ErrorResponse({
    this.status,
    this.statusCode,
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
  );
}