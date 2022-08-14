import 'package:flutter/material.dart';
import 'package:foodapp/routes/route_helper.dart';
import 'package:foodapp/utils/colors.dart';
import 'package:foodapp/widgets/big_text.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String tittle;
  final bool backButtonExist;
  final Function? onBackPressed;
  const CustomAppBar({
    Key? key,
    required this.tittle,
    this.backButtonExist = true,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: BigText(
          text: tittle,
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        elevation: 0,
        leading: backButtonExist
            ? IconButton(
                onPressed: () => onBackPressed != null
                    ? onBackPressed!()
                    // : Get.toNamed(RouteHelper.getInitial()),
                    : Get.offAllNamed(RouteHelper.initial),
                // : Navigator.pushReplacementNamed(context, "/initial"),
                icon: const Icon(Icons.arrow_back_ios),
              )
            : const SizedBox());
  }

  @override
  Size get preferredSize => const Size(500, 55);
}
