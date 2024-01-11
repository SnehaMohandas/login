import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log_in/controller/network_controller.dart';
import 'package:log_in/views/splash/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
 
  final NetworkController networkController = Get.put(NetworkController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
         final SplashController splashController = Get.put(SplashController());
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo_splash.png"),
                          fit: BoxFit.cover)),
                ),
              )
            ],
          ),
        );
      } else {
        return networkController.noDataImage(context);
      }
    });
  }
}
