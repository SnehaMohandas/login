import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:log_in/controller/network_controller.dart';
import 'package:log_in/utils/color_constants.dart';
import 'package:log_in/utils/image_constants.dart';
import 'package:log_in/views/login/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  
  final NetworkController networkController = Get.find<NetworkController>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final LoginController loginController = Get.put(LoginController());
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(AssetImages.backgrnd),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.translate,
                                      color: ColorConstant.blue,
                                    ),
                                    Text(
                                      'English',
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                               SizedBox(
                                height: MediaQuery.of(context).size.height*0.22,
                              ),
                              const Text("Login",
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                  )),
                              const Text(
                                "Login to your vikn account",
                                style: TextStyle(
                                  color: ColorConstant.slate,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(15)),
                                  border: Border.all(
                                      color: ColorConstant.slate, width: 0.3),
                                  color: ColorConstant.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.person_2_outlined,
                                        color: ColorConstant.blue,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: TextFormField(
                                          controller: userNameController,
                                          decoration: const InputDecoration(
                                            hintStyle: TextStyle(
                                                color: ColorConstant.slate),
                                            contentPadding: EdgeInsets.all(5),
                                            label: Text('Username'),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter your username";
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstant.slate, width: 0.3),
                                  borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(15)),
                                  color: ColorConstant.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.key,
                                        color: ColorConstant.blue,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        child: TextFormField(
                                          controller: passwordController,
                                          obscureText:
                                              loginController.obscureText.value,
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                                color: ColorConstant.slate),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                loginController
                                                    .toggleVisibility();
                                              },
                                              icon: loginController
                                                          .obscureText.value ==
                                                      true
                                                  ? const Icon(
                                                      Icons
                                                          .remove_red_eye_outlined,
                                                      color: ColorConstant.blue,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .visibility_off_outlined,
                                                      color: ColorConstant.blue,
                                                      size: 22,
                                                    ),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(5),
                                            label: const Text('Password'),
                                            border: InputBorder.none,
                                          ),
                                          validator: (value) {
                                            if (value == null || value == "") {
                                              return "Please enter your password";
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "Forgotten Password?",
                                style: TextStyle(
                                  color: ColorConstant.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    await loginController.login(
                                        userNameController.text,
                                        passwordController.text);
                                  }
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  decoration: BoxDecoration(
                                      color: ColorConstant.blue,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(
                                      () => loginController.isLoading.value ==
                                              true
                                          ? const Center(
                                              child: CircularProgressIndicator(
                                                color: ColorConstant.white,
                                              ),
                                            )
                                          : const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Sign in",
                                                  style: TextStyle(
                                                    color: ColorConstant.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: ColorConstant.white,
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.16,
                              )
                            ],
                          ),

                          const Column(
                            children: [
                              Text("Don’t have an Account?",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  )),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "Sign up now!",
                                style: TextStyle(
                                  color: ColorConstant.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        return networkController.noDataImage(context);
      }
    });
  }
}
