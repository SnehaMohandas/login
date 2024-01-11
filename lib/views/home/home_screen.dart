import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:log_in/controller/network_controller.dart';
import 'package:log_in/utils/color_constants.dart';
import 'package:log_in/views/login/login_screen.dart';
import 'package:log_in/views/home/sales_controller.dart';
import 'package:log_in/views/home/sales_model.dart';
import 'package:log_in/utils/common_function.dart';
import 'package:log_in/widgets/divider.dart';
import 'package:log_in/widgets/sale_Item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final NetworkController networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (networkController.isConnected.value) {
        final SaleController saleController = Get.put(SaleController());
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text('Are you sure to exit?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstant.blue,
                        ),
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                            color: ColorConstant.white,
                          ),
                        ))
                  ],
                );
              },
            );
          },
          child: Scaffold(
            backgroundColor: ColorConstant.white,
            appBar: AppBar(
              backgroundColor: ColorConstant.white,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.add,
                    color: ColorConstant.blue,
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      logoutDialogue(context);
                    },
                    icon: const Icon(Icons.logout))
              ],
              title: const Text(
                "Sales Estimate",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Divider(
                    thickness: 0.5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.slate,
                        ),
                        border: InputBorder.none,
                        hintText: 'Search',
                        suffixIcon: Icon(
                          Icons.search,
                          color: ColorConstant.slate,
                        ),
                      ),
                    ),
                  ),
                  gradientDivider(context),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => saleController.isLoading.value == true
                        ? const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorConstant.blue,
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: saleController.sales.length + 1,
                              itemBuilder: (context, index) {
                                if (index == saleController.sales.length) {
                                  if (saleController.currentPage *
                                          saleController.itemsPerPage <
                                      saleController.totalCount.value) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        saleController.loadNextPage();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all<Color>(ColorConstant.blue
                                                ),
                                      ),
                                      child: const Text("Next",style: TextStyle(color: ColorConstant.white),),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                } else {
                                  var sale = saleController.sales[index];

                                  return SaleItems(
                                      context,
                                      sale.voucherNo,
                                      sale.status,
                                      sale.customerName,
                                      sale.grandTotalRounded);
                                }
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        return networkController.noDataImage(context);
      }
    });
  }

  logoutDialogue(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: const Text('Logout?', style: TextStyle(fontSize: 17)),
            content: const Text('Are you sure want to Logout?',
                style: TextStyle(fontSize: 14)),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(ColorConstant.blue)),
                  onPressed: () async {
                    Get.offAll(() => LoginScreen());
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(color: ColorConstant.white),
                  ))
            ],
          ),
        );
      },
    );
  }
}
