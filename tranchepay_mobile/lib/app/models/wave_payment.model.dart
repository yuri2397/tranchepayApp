import 'dart:convert';

WavePaymentResponse wavePaymentResponseFromJson(String str) => WavePaymentResponse.fromJson(json.decode(str));

String wavePaymentResponseToJson(WavePaymentResponse data) => json.encode(data.toJson());

class WavePaymentResponse {
  WavePaymentResponse({
    required this.padding,
    required this.code,
    required this.message,
    required this.data,
  });

  String padding;
  int code;
  String message;
  Data data;

  factory WavePaymentResponse.fromJson(Map<String, dynamic> json) => WavePaymentResponse(
    padding: json["padding"],
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "padding": padding,
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.id,
    required this.amount,
    required this.checkoutStatus,
    required this.clientReference,
    required this.currency,
    required this.errorUrl,
    this.lastPaymentError,
    required this.businessName,
    required this.paymentStatus,
    required this.successUrl,
    required this.waveLaunchUrl,
    this.whenCompleted,
    required this.whenCreated,
    required this.whenExpires,
  });

  String id;
  String amount;
  String checkoutStatus;
  String clientReference;
  String currency;
  String errorUrl;
  dynamic lastPaymentError;
  String businessName;
  String paymentStatus;
  String successUrl;
  String waveLaunchUrl;
  dynamic whenCompleted;
  DateTime whenCreated;
  DateTime whenExpires;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    amount: json["amount"],
    checkoutStatus: json["checkout_status"],
    clientReference: json["client_reference"],
    currency: json["currency"],
    errorUrl: json["error_url"],
    lastPaymentError: json["last_payment_error"],
    businessName: json["business_name"],
    paymentStatus: json["payment_status"],
    successUrl: json["success_url"],
    waveLaunchUrl: json["wave_launch_url"],
    whenCompleted: json["when_completed"],
    whenCreated: DateTime.parse(json["when_created"]),
    whenExpires: DateTime.parse(json["when_expires"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "checkout_status": checkoutStatus,
    "client_reference": clientReference,
    "currency": currency,
    "error_url": errorUrl,
    "last_payment_error": lastPaymentError,
    "business_name": businessName,
    "payment_status": paymentStatus,
    "success_url": successUrl,
    "wave_launch_url": waveLaunchUrl,
    "when_completed": whenCompleted,
    "when_created": whenCreated.toIso8601String(),
    "when_expires": whenExpires.toIso8601String(),
  };
}