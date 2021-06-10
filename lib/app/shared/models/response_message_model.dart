// To parse this JSON data, do
//
//     final responseMessageModel = responseMessageModelFromJson(jsonString);

import 'dart:convert';

ResponseMessageModel responseMessageModelFromJson(String str) => ResponseMessageModel.fromJson(json.decode(str));

String responseMessageModelToJson(ResponseMessageModel data) => json.encode(data.toJson());

class ResponseMessageModel {
  ResponseMessageModel({
    required this.message,
    required this.success,
    required this.data,
  });

  String message;
  bool success;
  dynamic data;

  factory ResponseMessageModel.fromJson(Map<String, dynamic> json) => ResponseMessageModel(
    message: json["message"] == null ? null : json["message"],
    success: json["success"] == null ? null : json["success"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "success": success == null ? null : success,
    "data": data,
  };
}
