import 'package:flutter/material.dart';
import 'package:foodapp/controllers/order_controller.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/utils/styles.dart';
import 'package:get/get.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String tittle;
  final double amount;
  final bool isFree;

  const DeliveryOptions({
    Key? key,
    required this.value,
    required this.isFree,
    required this.amount,
    required this.tittle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) {
        return Row(
          children: [
            Radio(
              value: value,
              groupValue: orderController.orderType,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (String? value) {
                return orderController.setDeliveryType(value!);
              },
            ),
            SizedBox(width: Dimensions.width10 / 2),
            Text(tittle, style: robotoRegular),
            SizedBox(width: Dimensions.width10 / 2),
            Text(
              '(${(value == 'Take away' || isFree) ? 'free' : '\$${amount / 10}'})',
              style: robotoMedium,
            )
          ],
        );
      },
    );
  }
}
