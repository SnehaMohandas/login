// To parse this JSON data, do
//
//     final salesModel = salesModelFromJson(jsonString);

import 'dart:convert';

SalesModel salesModelFromJson(String str) =>
    SalesModel.fromJson(json.decode(str));

String salesModelToJson(SalesModel data) => json.encode(data.toJson());

class SalesModel {
  int statusCode;
  List<Datum> data;
  int totalCount;

  SalesModel({
    required this.statusCode,
    required this.data,
    required this.totalCount,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(
        statusCode: json["StatusCode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
        "StatusCode": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total_count": totalCount,
      };
}

class Datum {
  int index;
  dynamic id;
  dynamic voucherNo;
  dynamic date;
  dynamic ledgerName;
  dynamic totalGrossAmtRounded;
  dynamic totalTaxRounded;
  dynamic grandTotalRounded;
  dynamic customerName;
  dynamic totalTax;
  dynamic status;
  dynamic grandTotal;
  bool isBillwised;
  dynamic billwiseStatus;

  Datum({
    required this.index,
    required this.id,
    required this.voucherNo,
    required this.date,
    required this.ledgerName,
    required this.totalGrossAmtRounded,
    required this.totalTaxRounded,
    required this.grandTotalRounded,
    required this.customerName,
    required this.totalTax,
    required this.status,
    required this.grandTotal,
    required this.isBillwised,
    required this.billwiseStatus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        index: json["index"],
        id: json["id"],
        voucherNo: json["VoucherNo"],
        date: DateTime.parse(json["Date"]),
        ledgerName: json["LedgerName"]! ?? "",
        totalGrossAmtRounded: json["TotalGrossAmt_rounded"]?.toDouble(),
        totalTaxRounded: json["TotalTax_rounded"],
        grandTotalRounded: json["GrandTotal_Rounded"]?.toDouble(),
        customerName: json["CustomerName"]! ?? "",
        totalTax: json["TotalTax"],
        status: json["Status"]!,
        grandTotal: json["GrandTotal"]?.toDouble(),
        isBillwised: json["is_billwised"],
        billwiseStatus: json["billwise_status"]!,
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "id": id,
        "VoucherNo": voucherNo,
        "Date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "LedgerName": ledgerName,
        "TotalGrossAmt_rounded": totalGrossAmtRounded,
        "TotalTax_rounded": totalTaxRounded,
        "GrandTotal_Rounded": grandTotalRounded,
        "CustomerName": customerName,
        "TotalTax": totalTax,
        "Status": status,
        "GrandTotal": grandTotal,
        "is_billwised": isBillwised,
        "billwise_status": billwiseStatus,
      };
}
