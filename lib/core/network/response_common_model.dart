import 'dart:developer';

class ResponseCommonModel {
  bool? status;
  String? message;
  String? exceptionMessage;

  ResponseCommonModel({
    this.status,
    this.message,
    this.exceptionMessage,
  });

  ResponseCommonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? false;
    message = json['message'] ?? "";

    try {
      if (json['errors'] != null) {
        if (json['errors'].runtimeType == List &&
            (json['errors'] as List).isNotEmpty) {
          if (json['errors'][0]['message'] != null) {
            exceptionMessage = json['errors'][0]['message'];
          }
        } else if (json['errors'].runtimeType is Map) {
          if (json['errors']['message'] != null) {
            exceptionMessage = json['errors']['message'];
          }
        } else if (json['errors'] == String) {
          exceptionMessage = json['errors'];
        }
      }
    } catch (error) {
      log("Error in converting json to response common model:: $error");
    }
  }
}
