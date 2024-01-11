import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:log_in/utils/color_constants.dart';
import 'package:log_in/utils/const.dart';
import 'package:log_in/views/home/home_screen.dart';
import 'package:log_in/views/login/login_model.dart';
import 'package:log_in/utils/common_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  LoginModel? loginModel;

  RxBool obscureText = true.obs;
  var isLoading = false.obs;

  toggleVisibility() {
    obscureText.value = !obscureText.value;
  }

  login(String userName, String password) async {
    try {
      isLoading.value = true;
      var response = await http.post(
          Uri.parse("https://api.accounts.vikncodes.com/api/v1/users/login"),
          body: ({"username": userName, "password": password}));

      if (response.statusCode == 200 &&
          json.decode(response.body)["success"] == 6000) {
        loginModel = loginModelFromJson(response.body);
        token = loginModel!.data.access;
        isLoading.value = false;
        Fluttertoast.showToast(
          msg: "Login Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
        CommonFunction.addDataToSharedPreferences(
            "token", loginModel!.data.access);
        Get.offAll(() => HomeScreen());
        print(response.body);
      } else {
        isLoading.value = false;

        Fluttertoast.showToast(
          msg: "Incorrect Username or Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorConstant.black,
          textColor: ColorConstant.white,
        );
      }
    } catch (e) {}
  }
}
