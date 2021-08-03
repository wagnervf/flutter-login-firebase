import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/buttom_nav_bar.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_loggin_firebase/app/shared/enums.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:get/get.dart';

import 'icon_button_custom.dart';

// ignore: use_key_in_widget_constructors
class HomeView extends StatelessWidget {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
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
                    buildSearch(context),
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
              const Center(
                child: Text("Home Page", style: headerStyle),
              ),
              TextButton(
                onPressed: () => loginController.setLogoutAll(),
                child: const Text('Logout'),
              ),
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

  Container buildSearch(BuildContext context) {
    return Container(
      width: getWidth(context) * 0.6,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => {},
        decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: (20), vertical: (9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
