import 'dart:convert';

OmPaymentResponse omPaymentResponseFromJson(String str) =>
    OmPaymentResponse.fromJson(json.decode(str));

String omPaymentResponseToJson(OmPaymentResponse data) =>
    json.encode(data.toJson());

class OmPaymentResponse {
  OmPaymentResponse({
    required this.response,
    required this.padding,
  });

  Response response;
  String padding;

  factory OmPaymentResponse.fromJson(Map<String, dynamic> json) =>
      OmPaymentResponse(
        response: Response.fromJson(json["response"]),
        padding: json["padding"],
      );

  Map<String, dynamic> toJson() => {
        "response": response.toJson(),
        "padding": padding,
      };
}

class Response {
  Response({
    required this.reference,
    required this.transactionId,
    required this.requestId,
    required this.status,
    required this.description,
  });

  String reference;
  String transactionId;
  String requestId;
  String status;
  String description;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        reference: json["reference"],
        transactionId: json["transactionId"],
        requestId: json["requestId"],
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "transactionId": transactionId,
        "requestId": requestId,
        "status": status,
        "description": description,
      };
}
