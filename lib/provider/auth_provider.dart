import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:wingman/utils/apis.dart';
import 'package:wingman/utils/constants.dart';
import 'package:wingman/utils/state.dart';

class AuthProvider extends ChangeNotifier {
  var client = http.Client();
  var sendOTPState = StateEnum.empty;
  var verifyOTPState = StateEnum.empty;
  var profileState = StateEnum.empty;
  var otpID = "";
  Future sendOTP({required String phone}) async {
    sendOTPState = StateEnum.loading;
    notifyListeners();
    try {
      var response = await http.post(Uri.parse(Api.sendOTP),
          body: json.encode({'mobile': phone}));
      log(response.body);
      if (response.statusCode == 200 &&
          jsonDecode(response.body)["status"] == true) {
        sendOTPState = StateEnum.success;
        otpID = jsonDecode(response.body)["request_id"];
        notifyListeners();
      } else {
        sendOTPState = StateEnum.error;
        notifyListeners();
      }
    } on HttpException catch (e) {
      sendOTPState = StateEnum.error;
      notifyListeners();
      log(e.message);
    }
  }

  Future verifyOTP({required String otp}) async {
    verifyOTPState = StateEnum.loading;
    notifyListeners();

    try {
      var response = await http.post(Uri.parse(Api.verifyOTP),
          body: json.encode({
            'request_id': otpID,
            "code": otp,
          }));

      if (response.statusCode == 200 &&
          jsonDecode(response.body)["status"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonDecode(response.body)['jwt']);
        token = jsonDecode(response.body)['jwt'];
        prefs.setBool('onboard', jsonDecode(response.body)['profile_exists']);

        name = 'WINGMAN';
        prefs.setString('name', name);

        verifyOTPState = StateEnum.success;
        notifyListeners();
        return jsonDecode(response.body)['profile_exists'];
      } else {
        verifyOTPState = StateEnum.error;
        notifyListeners();
      }
      return false;
    } on HttpException catch (e) {
      //  log(e.);
      verifyOTPState = StateEnum.error;
      notifyListeners();

    }
  }

  Future updateProfile(
      {required String userName, required String email}) async {
    profileState = StateEnum.loading;
    notifyListeners();

    try {
      var response = await http.post(Uri.parse(Api.profile),
          body: json.encode(
            {
              'name': userName,
              "email": email,
            },
          ),
          headers: {"Token": token});
      log(response.body);
      if (response.statusCode == 200 &&
          jsonDecode(response.body)["status"] == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('name', userName);
        name = userName;
        prefs.setBool('onboard', true);
        profileState = StateEnum.success;
        notifyListeners();
      } else {
        profileState = StateEnum.error;
        notifyListeners();
      }
    } on HttpException catch (e) {
      log(e.message);
      profileState = StateEnum.error;
      notifyListeners();
    }
  }
}
