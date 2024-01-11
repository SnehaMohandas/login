import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:log_in/utils/color_constants.dart';
import 'package:log_in/utils/const.dart';
import 'package:log_in/views/home/sales_model.dart';

class SaleController extends GetxController {
  SalesModel? salesModel;
  var sales = <Datum>[].obs;
  var currentPage = 1.obs;
  var itemsPerPage = 10;
  var totalCount = 0.obs;
  var isLoading = true.obs;

  void loadNextPage() {
    currentPage++;
    _loadData();
  }

  Future<void> _loadData() async {
    Map<String, dynamic> payload = {
      "BranchID": 1,
      "CompanyID": "1901b825-fe6f-418d-b5f0-7223d0040d08",
      "CreatedUserID": 62,
      "PriceRounding": 3,
      "page_no": currentPage.value,
      "items_per_page": itemsPerPage,
      "type": "Sales",
      "WarehouseID": 1,
    };

    try {
      if (currentPage.value == 1) {
        isLoading.value = true;
      }
      var response = await http.post(
        Uri.parse(
            "https://www.api.viknbooks.com/api/v10/sales/sale-list-page/"),
        body: jsonEncode(payload),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 &&
          json.decode(response.body)["StatusCode"] == 6000) {
        salesModel = salesModelFromJson(response.body);
        if (currentPage.value == 1) {
          sales.clear();
        }

        sales.addAll(salesModel!.data);
        totalCount.value = salesModel!.totalCount;
      } else {}
      isLoading.value = false;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorConstant.black,
        textColor: ColorConstant.white,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }
}
