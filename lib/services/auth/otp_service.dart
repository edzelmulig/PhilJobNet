import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:philjobnet/constant.dart';

class OTPService {
  static const String _baseUrl = 'https://app.philsms.com/api/v3/sms/send';

  static Future sendOTP(String? phoneNumber, String otpMessage) async {
    String formattedNumber = '63${phoneNumber!.substring(1)}';
    var url = Uri.parse(_baseUrl);
    var headers = {
      'Authorization': smsAPI,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var body = jsonEncode({
      "recipient": formattedNumber,
      "sender_id": "PhilSMS",
      "type": 'plain',
      "message": otpMessage,
    });

    try {
      var response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        debugPrint('SMS sent successfully: ${response.body}');
        debugPrint("SENT GENERATED NUMBER: $otpMessage");
      } else {
        debugPrint('Failed to send SMS: ${response.body}');
      }
    } catch (error) {
      debugPrint('Error sending OTP: $error');
    }
  }
}