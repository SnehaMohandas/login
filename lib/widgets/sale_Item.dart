import 'package:flutter/material.dart';
import 'package:log_in/utils/color_constants.dart';
import 'package:log_in/widgets/divider.dart';

Widget SaleItems(context, invoiceNo, status, customerName, amount) {
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#${invoiceNo}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                status,
                style: TextStyle(
                  color: status == "Pending"
                      ? ColorConstant.red
                      : status == "Invoiced"
                          ? ColorConstant.blue
                          : ColorConstant.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${customerName}",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'SAR.',
                    style: TextStyle(fontSize: 12, color: ColorConstant.slate),
                  ),
                  Text(
                    "${amount}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          gradientDivider(context),
        ],
      ),
    ),
  );
}
