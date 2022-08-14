import 'package:flutter/material.dart';
import 'package:foodapp/base/common_text_button.dart';
import 'package:foodapp/base/no_data_page.dart';
import 'package:foodapp/base/show_custom_snacbar.dart';

import 'package:foodapp/controllers/auth_controller.dart';

import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/order_controller.dart';
import 'package:foodapp/controllers/popular_product_controller.dart';
import 'package:foodapp/controllers/recommended_product_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/models/place_order_model.dart';
import 'package:foodapp/pages/order/delivery_options.dart';

import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/app_constants.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/app_text_field.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:foodapp/pages/order/payment_options_button.dart';
import 'package:foodapp/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();

    return Scaffold(
        body: Stack(
          children: [
            //* Bagian Icon
            Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  SizedBox(width: Dimensions.width20 * 5),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ],
              ),
            ),

            //* Bagian barang
            GetBuilder<CartController>(builder: (_cartController) {
              return _cartController.getItems.length > 0
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        // color: Colors.red,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: GetBuilder<CartController>(
                            builder: (controller) {
                              var _cartList = controller.getItems;
                              return ListView.builder(
                                itemCount: _cartList.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    width: double.maxFinite,
                                    height: Dimensions.height20 * 5,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            var popularIndex = Get.find<
                                                    PopularProductController>()
                                                .popularProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            if (popularIndex >= 0) {
                                              Get.toNamed(
                                                  RouteHelper.getPopularFood(
                                                      popularIndex,
                                                      "cartpage"));
                                            } else {
                                              var recommendedIndex = Get.find<
                                                      RecommendedProductController>()
                                                  .recommendedProductList
                                                  .indexOf(_cartList[index]
                                                      .product!);
                                              if (recommendedIndex < 0) {
                                                Get.snackbar("History product",
                                                    "Product review is not available for history products",
                                                    backgroundColor:
                                                        AppColors.mainColor,
                                                    colorText: Colors.white);
                                              } else {
                                                Get.toNamed(RouteHelper
                                                    .getRecommendedFood(
                                                        recommendedIndex,
                                                        "cartpage"));
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: Dimensions.height20 * 5,
                                            height: Dimensions.height20 * 5,
                                            margin: EdgeInsets.only(
                                                bottom: Dimensions.height10),
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants
                                                              .UPLOAD_URL +
                                                          controller
                                                              .getItems[index]
                                                              .img!),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius20),
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.width10),
                                        Expanded(
                                          child: Container(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: controller
                                                      .getItems[index].name!,
                                                  color: Colors.black54,
                                                ),
                                                SmallText(text: "Spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text: "\$ " +
                                                          controller
                                                              .getItems[index]
                                                              .price
                                                              .toString(),
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  Dimensions
                                                                      .height10,
                                                              vertical:
                                                                  Dimensions
                                                                      .width10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        color: Colors.white,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1,
                                                              );
                                                            },
                                                            child: Icon(
                                                                Icons.remove,
                                                                color: AppColors
                                                                    .signColor),
                                                          ),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .width10 /
                                                                  2),
                                                          BigText(
                                                            text:
                                                                _cartList[index]
                                                                    .quantity
                                                                    .toString(),
                                                          ),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .width10 /
                                                                  2),
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                1,
                                                              );
                                                            },
                                                            child: Icon(
                                                                Icons.add,
                                                                color: AppColors
                                                                    .signColor),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : NoDataPage(text: "Your card is empty");
            })
          ],
        ),

        //* Bagian bottom navbar
        bottomNavigationBar: GetBuilder<OrderController>(
          builder: (orderController) {
            _noteController.text = orderController.foodNote;
            return GetBuilder<CartController>(
              builder: (cartController) {
                return Container(
                  height: Dimensions.bottomHeightBar + 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2),
                    ),
                  ),
                  child: cartController.getItems.length > 0
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () => showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (_) {
                                  return Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Container(
                                            height:
                                                Dimensions.screenHeight * 0.9,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimensions.radius20),
                                                topRight: Radius.circular(
                                                    Dimensions.radius20),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  // height: 520,
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions.width20,
                                                      right: Dimensions.width20,
                                                      top: Dimensions.height20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      PaymentOptionButton(
                                                        iconData: Icons.money,
                                                        index: 0,
                                                        subTittle:
                                                            "you pay after getting the delivery",
                                                        tittle:
                                                            'cash on delivery',
                                                      ),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      PaymentOptionButton(
                                                        iconData: Icons
                                                            .paypal_outlined,
                                                        index: 1,
                                                        subTittle:
                                                            "safer and faster way of payment",
                                                        tittle:
                                                            'digital payment',
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height30,
                                                      ),
                                                      BigText(
                                                        text:
                                                            "Delivery options",
                                                        size: Dimensions.font20,
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                                .height10 /
                                                            2,
                                                      ),
                                                      DeliveryOptions(
                                                        value: "delivery",
                                                        isFree: false,
                                                        amount: double.parse(
                                                            Get.find<
                                                                    CartController>()
                                                                .totalAmount
                                                                .toString()),
                                                        tittle: "Home delivery",
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                                .height10 /
                                                            2,
                                                      ),
                                                      DeliveryOptions(
                                                        value: "take away",
                                                        isFree: true,
                                                        amount: double.parse(
                                                            Get.find<
                                                                    CartController>()
                                                                .totalAmount
                                                                .toString()),
                                                        tittle: "Take away",
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.height20,
                                                      ),
                                                      BigText(
                                                        text: "Aditional notes",
                                                        size: Dimensions.font20,
                                                      ),
                                                      AppTextField(
                                                        textController:
                                                            _noteController,
                                                        hintText: '',
                                                        iconData: Icons.note,
                                                        color:
                                                            AppColors.mainColor,
                                                        maxLines: true,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ).whenComplete(
                                () => orderController
                                    .setFoodNote(_noteController.text.trim()),
                              ),
                              child: CommonTextButton(text: "Payment options"),
                            ),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.height20,
                                      vertical: Dimensions.width20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: Dimensions.width10 / 2),
                                      BigText(
                                          text: "\$ " +
                                              cartController.totalAmount
                                                  .toString()),
                                      SizedBox(width: Dimensions.width10 / 2),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      // if (Get.find<AuthController>().userLoggedIn()) {
                                      //   // print("tapped");
                                      //   cartController.addToHistory();
                                      //   Get.toNamed(RouteHelper.getInitial());
                                      // } else {
                                      //   Get.toNamed(RouteHelper.getSignInPage());
                                      // }
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        if (Get.find<LocationController>()
                                            .addressList
                                            .isEmpty) {
                                          Get.toNamed(
                                              RouteHelper.getAddressPage());
                                        } else {
                                          var location =
                                              Get.find<LocationController>()
                                                  .getUserAddress();
                                          var cart = Get.find<CartController>()
                                              .getItems;
                                          var user = Get.find<UserController>()
                                              .userModel;
                                          PlaceOrderBody placeOrder =
                                              PlaceOrderBody(
                                            cart: cart,
                                            orderAmount: 100.0,
                                            distance: 10.0,
                                            scheduleAt: '',
                                            orderNote: orderController.foodNote,
                                            address: location.address,
                                            latitude: location.latitude,
                                            longitude: location.longitude,
                                            contactPersonName: user!.name,
                                            contactPersonNumber: user.phone,
                                            paymentMethod:
                                                orderController.paymentIndex ==
                                                        0
                                                    ? 'cash_on_delivery'
                                                    : 'digital_payment',
                                            orderType:
                                                orderController.orderType,
                                          );
                                          Get.find<OrderController>()
                                              .placeOrder(
                                            placeOrder,
                                            _callback,
                                          );
                                        }
                                      } else {
                                        Get.toNamed(
                                            RouteHelper.getSignInPage());
                                      }
                                    },
                                    child: CommonTextButton(text: "Check out"))
                              ],
                            )
                          ],
                        )
                      : Container(),
                );
              },
            );
          },
        ));
  }

  void _callback(bool isSucces, String message, String orderID) {
    if (isSucces) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel!.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
