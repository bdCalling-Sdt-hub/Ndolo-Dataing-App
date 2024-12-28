import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../helpers/prefs_helpers.dart';
import '../helpers/route.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_colors.dart';
import '../utils/app_constants.dart';

class AuthController extends GetxController {
  //================================> Sign Up <=================================
  final TextEditingController firstNameCTR = TextEditingController();
  final TextEditingController emailCTR = TextEditingController();
  final TextEditingController passCTR = TextEditingController();
  final TextEditingController birthDateCTRL = TextEditingController();
  final TextEditingController locationCTRL = TextEditingController();
  final TextEditingController bioCTRL = TextEditingController();

  // RxBool isSelectedRole = true.obs;
  var signUpLoading = false.obs;
  var token = "";
/*

  handleSignUp() async {
    signUpLoading(true);
    var userRole = await PrefsHelper.getString(AppConstants.userRole);
    Map<String, dynamic> body = {
      "name": nameCtrl.text.trim(),
      "email": emailCtrl.text.trim(),
      "password": passwordCtrl.text,
      "division": selectDivision.value,
      "role": userRole,
      "fcmToken": "fcmToken..",

    };

    var headers = {'Content-Type': 'application/json'};

    Response response = await ApiClient.postData(
        ApiConstants.signUpEndPoint, jsonEncode(body),
        headers: headers);
    if (response.statusCode == 201 || response.statusCode == 200) {
      Get.toNamed(AppRoutes.otpScreen, parameters: {
        "email": emailCtrl.text.trim(),
        "screenType": "signup",
      });
      nameCtrl.clear();
      emailCtrl.clear();
      passwordCtrl.clear();
      confirmCtrl.clear();
      signUpLoading(false);
      selectDivision.value ='';
      update();
    } else {
      ApiChecker.checkApi(response);
      signUpLoading(false);
      update();
    }
  }
*/

  //==================================> Sign In <================================
  TextEditingController signInEmailCtrl = TextEditingController();
  TextEditingController signInPassCtrl = TextEditingController();

  /*
  var signInLoading = false.obs;
  handleLogIn() async {
    signInLoading(true);
    var headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      'email': signInEmailCtrl.text.trim(),
      'password': signInPassCtrl.text.trim(),
      "fcmToken": "fcmToken..",
    };
    Response response = await ApiClient.postData(
        ApiConstants.logInEndPoint, json.encode(body),
        headers: headers);
    print("====> ${response.body}");
    if (response.statusCode == 200) {
      await PrefsHelper.setString(AppConstants.bearerToken,
          response.body['data']['attributes']['tokens']['access']['token']);
      await PrefsHelper.setString(
          AppConstants.id, response.body['data']['attributes']['user']['id']);
      String userRole = response.body['data']['attributes']['user']['role'];
      await PrefsHelper.setString(AppConstants.userRole, userRole);
      await PrefsHelper.setBool(AppConstants.isLogged, true);
      if (userRole == UserRole.player.name) {
        Get.offAllNamed(AppRoutes.playerHomeScreen);
        await PrefsHelper.setBool(AppConstants.isLogged, true);
      } else if (userRole == UserRole.trainer.name) {
        Get.offAllNamed(AppRoutes.trainerHomeScreen);
        await PrefsHelper.setBool(AppConstants.isLogged, true);
      } else if (userRole == UserRole.agency.name) {
        Get.offAllNamed(AppRoutes.agencyHomeScreen);
        await PrefsHelper.setBool(AppConstants.isLogged, true);
      } else if (userRole == UserRole.club.name) {
        Get.offAllNamed(AppRoutes.clubHomeScreen);
        await PrefsHelper.setBool(AppConstants.isLogged, true);
      }
      signInEmailCtrl.clear();
      signInPassCtrl.clear();
      signInLoading(false);
      update();
    } else {
      ApiChecker.checkApi(response);
      Fluttertoast.showToast(msg: response.statusText ?? "");
    }
    signInLoading(false);
  }
*/
  //=================> Resend otp <=====================
  var resendOtpLoading = false.obs;
  /* resendOtp(String email) async {
    resendOtpLoading(true);
    var body = {"email": email};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.forgotPassEndPoint, json.encode(body),
        headers: header);
    print("===> ${response.body}");
    if (response.statusCode == 200) {
    } else {
      Fluttertoast.showToast(
          msg: response.statusText ?? "",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.CENTER);
    }
    resendOtpLoading(false);
  }
*/
  //===================> Otp very <=======================
  TextEditingController otpCtrl = TextEditingController();
  var verifyLoading = false.obs;
  /* handleOtpVery(
      {required String email,
      required String otp,
      required String type}) async {
    try {
      var body = {'oneTimeCode': otpCtrl.text, 'email': email};
      var headers = {'Content-Type': 'application/json'};
      verifyLoading(true);
      Response response = await ApiClient.postData(
          ApiConstants.otpVerifyEndPoint, jsonEncode(body),
          headers: headers);
      print("============${response.body} and ${response.statusCode}");
      if (response.statusCode == 200) {
        print(
            'token>>>>${response.body["data"]['attributes']['tokens']['access']['token']}');
        await PrefsHelper.setString(AppConstants.userRole,
            response.body["data"]['attributes']['user']['role']);
        await PrefsHelper.setString(AppConstants.bearerToken,
            response.body["data"]['attributes']['tokens']['access']['token']);
        var role = response.body["data"]['attributes']['user']['role'];
        print("===> role : $role");
        otpCtrl.clear();
        if (type == "forgetPasswordScreen") {
          Get.toNamed(AppRoutes.setNewPasswordScreen,
              parameters: {"email": email});
        } else {
          Get.toNamed(AppRoutes.selectCountryScreen);
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e, s) {
      print("===> e : $e");
      print("===> s : $s");
    }
    verifyLoading(false);
  }*/

  //====================> Forgot pass word <=====================
  TextEditingController forgetEmailTextCtrl = TextEditingController();
  var forgotLoading = false.obs;
/*

  handleForget() async {
    forgotLoading(true);
    var body = {
      "email": forgetEmailTextCtrl.text.trim(),
    };
    var headers = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.forgotPassEndPoint, json.encode(body),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Get.toNamed(AppRoutes.otpScreen, parameters: {
        "email": forgetEmailTextCtrl.text.trim(),
        "screenType": "forgetPasswordScreen",
      });
      forgetEmailTextCtrl.clear();
    } else {
      ApiChecker.checkApi(response);
    }
    forgotLoading(false);
  }
*/

  //======================> Handle Change password <============================
  var changeLoading = false.obs;
  TextEditingController currentPasswordCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
/*
  handleChangePassword(String oldPassword, String newPassword) async {
    changeLoading(true);
    var body = {"oldPassword": oldPassword, "newPassword": newPassword};
    var response = await ApiClient.postData(ApiConstants.changePassEndPoint, body);
    print("===============> ${response.body}");
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: response.body['message'],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: AppColors.cardLightColor,
          textColor: Colors.white);
      Get.back();
      Get.back();
    } else {
      ApiChecker.checkApi(response);
    }
    changeLoading(false);
  }
*/

  //=============================> Set New password <===========================
  var resetPasswordLoading = false.obs;
/*
  resetPassword(String email, String password) async {
    print("=======> $email, and $password");
    resetPasswordLoading(true);
    var body = {"email": email, "password": password};
    Map<String, String> header = {'Content-Type': 'application/json'};
    var response = await ApiClient.postData(
        ApiConstants.resetPassEndPoint, json.encode(body),
        headers: header);
    if (response.statusCode == 200) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
                backgroundColor: AppColors.cardLightColor,
                title: const Text("Password reset!"),
                content:
                    const Text("Your password has been reset successfully."),
                actions: [
                  TextButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.white)),
                      onPressed: () {
                        Get.toNamed(AppRoutes.signInScreen);
                      },
                      child: const Text("Ok"))
                ],
              ));
    } else {
      debugPrint("error set password ${response.statusText}");
      Fluttertoast.showToast(
        msg: "${response.statusText}",
      );
    }
    resetPasswordLoading(false);
  }
*/
}
