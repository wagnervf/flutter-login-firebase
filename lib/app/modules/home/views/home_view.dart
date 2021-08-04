import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/buttom_nav_bar.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_loggin_firebase/app/modules/user/controllers/user_controller.dart';
import 'package:flutter_loggin_firebase/app/shared/enums.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:get/get.dart';

import 'icon_button_custom.dart';

class HomeView extends StatelessWidget {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    //  final String? name = loginController.firebaseUser.displayName;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButtonCustom(
                      svgSrc: "assets/icons/Cart Icon.svg",
                      press: () {},
                    ),
                    IconButtonCustom(
                      svgSrc: "assets/icons/Bell.svg",
                      numOfitem: 3,
                      press: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: GetX<UserController>(builder: (_) {
                  return Column(
                    children: [
                      Text(_.user.displayName.toString()),
                      Text(_.user.email.toString()),
                    ],
                  );
                }),
              ),
              logoutFirebase(context),
              TextButton(
                onPressed: () => loginController.logoutGoogle(),
                child: const Text('Google Logout'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedMenu: MenuState.home),
    );
  }

  SizedBox logoutFirebase(BuildContext context) {
    return SizedBox(
      width: getWidth(context) * .7,
      height: getHeight(context) * .07,
      child: Obx(
        () => ElevatedButton(
          onPressed: () => loginController.setLogoutAll(),
          child: loginController.loading
              ? showLoading()
              : Text(
                  'Logout Firebase',
                  style: TextStyle(
                    fontSize: getHeight(context) * .03,
                    color: Colors.white,
                  ),
                ),
          style: styleElevatedButton(),
        ),
      ),
    );
  }
}
