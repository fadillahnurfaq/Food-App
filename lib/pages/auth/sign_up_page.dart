import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/base/custom_loader.dart';
import 'package:foodapp/base/show_custom_snacbar.dart';
import 'package:foodapp/controllers/auth_controller.dart';
import 'package:foodapp/models/signup_body_model.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/utils/dimensions.dart';
import 'package:foodapp/widgets/app_text_field.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (email.isEmpty) {
        showCustomSnackBar("Type in your email address",
            title: "Email address");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address",
            title: "Valid email address");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password can not be less than siz characters",
            title: "Password");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Sukses Registrasi");
            Get.toNamed(RouteHelper.getSignInPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
            //* Default isLoading = false;
            return !_authController.isLoading
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
                        //* Bagian Email
                        AppTextField(
                          textController: emailController,
                          hintText: "Email",
                          iconData: Icons.email,
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
                        //* Bagian Nama
                        AppTextField(
                          textController: nameController,
                          hintText: "Name",
                          iconData: Icons.person,
                          color: AppColors.mainColor,
                        ),
                        SizedBox(height: Dimensions.height20),
                        AppTextField(
                          textController: phoneController,
                          hintText: "Phone",
                          iconData: Icons.phone,
                          color: Colors.grey,
                        ),
                        SizedBox(height: Dimensions.height20 * 2),

                        //* Sign up button
                        GestureDetector(
                          onTap: () {
                            _registration(_authController);
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
                                text: "Sign Up",
                                size: Dimensions.font20 * 2 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height10),

                        //* Have an account already
                        RichText(
                          text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: "Have an account already?",
                            style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: Dimensions.font20),
                          ),
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.05),

                        //* Sign up options
                        RichText(
                          text: TextSpan(
                            text: "Sign up using one of the following methods",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16,
                            ),
                          ),
                        ),

                        SizedBox(height: Dimensions.height10),

                        //* Bagian Login Options
                        Wrap(
                          children: List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                radius: Dimensions.radius30 / 1.2,
                                backgroundImage: AssetImage(
                                    "assets/image/" + signUpImages[index]),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : CustomLoader();
          },
        ));
  }
}
