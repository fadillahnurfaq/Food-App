import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_app_bar.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/controllers/cart_controller.dart';
import 'package:foodapp/controllers/location_controller.dart';
import 'package:foodapp/controllers/user_controller.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/account_widget.dart';
import 'package:foodapp/widgets/app_icon.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(tittle: "Profile"),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return _userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize:
                                  Dimensions.height45 + Dimensions.height30,
                              size: Dimensions.height15 * 10,
                            ),
                            SizedBox(height: Dimensions.height20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //* Profile icon
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        backgroundColor: AppColors.mainColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text: userController.userModel!.name),
                                    ),
                                    SizedBox(height: Dimensions.height20),

                                    //* Phone
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.phone,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel!.phone),
                                    ),
                                    SizedBox(height: Dimensions.height20),

                                    //*Email
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.email,
                                        backgroundColor: AppColors.yellowColor,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(
                                          text:
                                              userController.userModel!.email),
                                    ),
                                    SizedBox(height: Dimensions.height20),

                                    //* Lokasi
                                    GetBuilder<LocationController>(
                                      builder: (locationControler) {
                                        if (_userLoggedIn &&
                                            locationControler
                                                .addressList.isEmpty) {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  RouteHelper.getAddressPage());
                                            },
                                            child: AccountWidget(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                    AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                iconSize:
                                                    Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              bigText: BigText(
                                                  text: "Fill in your address"),
                                            ),
                                          );
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  RouteHelper.getAddressPage());
                                            },
                                            child: AccountWidget(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                    AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                iconSize:
                                                    Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              bigText:
                                                  BigText(text: "Your address"),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    SizedBox(height: Dimensions.height20),

                                    //* Message
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message,
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(text: "Messages"),
                                    ),

                                    SizedBox(height: Dimensions.height20),
                                    //* Logout
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.offNamed(
                                              RouteHelper.getSignInPage());
                                        } else {
                                          print("You logged out");
                                        }
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Logout"),
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.height20),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : CustomLoader())
                : Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 8,
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimensions.width20),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/signintocontinue.png"),
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.height20),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getSignInPage());
                            },
                            child: Container(
                              width: Dimensions.width30 * 6,
                              height: Dimensions.height20 * 3,
                              margin: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width20),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                              ),
                              child: Center(
                                child: BigText(
                                  text: "Sign in",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ));
  }
}
