import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/pages/auth/sign_up_page.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_text_field.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snacbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone address",
            title: "phone address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than siz characters",
            title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.offNamed(RouteHelper.getInitial());
            // Get.toNamed(RouteHelper.getCartPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        //* Bagian logo
                        Container(
                          height: Dimensions.screenHeight * 0.25,
                          child: Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/image/logo_part1.png"),
                            ),
                          ),
                        ),

                        //* bagian Hello
                        Container(
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                    fontSize: Dimensions.font20 * 3 +
                                        Dimensions.font20 / 2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Sign into your account",
                                style: TextStyle(
                                    fontSize: Dimensions.font20,
                                    color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: Dimensions.height20),

                        //* Bagian phone
                        AppTextField(
                          textController: phoneController,
                          hintText: "phone",
                          iconData: Icons.phone,
                          color: AppColors.mainColor,
                        ),
                        SizedBox(height: Dimensions.height20),

                        //* Bagian Password
                        AppTextField(
                          textController: passwordController,
                          hintText: "Password",
                          iconData: Icons.password_sharp,
                          color: AppColors.mainColor,
                          isObscure: true,
                        ),

                        SizedBox(height: Dimensions.height20),

                        //* Sign into
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(right: Dimensions.width20),
                              child: RichText(
                                text: TextSpan(
                                  text: "Sign into your account",
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: Dimensions.font20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.05),

                        //* Sign in button
                        GestureDetector(
                          onTap: () {
                            _login(authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius30),
                                color: AppColors.mainColor),
                            child: Center(
                              child: BigText(
                                text: "Sign in",
                                size: Dimensions.font20 * 2 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        //* Bagian dont have
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        Center(
                          child: RichText(
                            text: TextSpan(
                                text: "Don\'t have an acoount?",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20,
                                ),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = (() => Get.to(
                                          () => SignUpPage(),
                                          transition: Transition.fade)),
                                    text: " Create",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.mainBlackColor,
                                      fontSize: Dimensions.font20,
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  )
                : CustomLoader();
          },
        ));
  }
}
