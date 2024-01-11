import 'package:get/get.dart';
import 'package:log_in/utils/const.dart';
import 'package:log_in/views/home/home_screen.dart';
import 'package:log_in/views/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  splashOn() async {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        token = await getSavedKey('token');

        if (token == null) {
          Get.offAll(LoginScreen());
        } else if (token != null) {
          Get.offAll(HomeScreen());
        }
      },
    );
  }

  static getSavedKey(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? values = prefs.getString(key);
    return values;
  }

  @override
  void onInit() {
    splashOn();
    super.onInit();
  }
}
