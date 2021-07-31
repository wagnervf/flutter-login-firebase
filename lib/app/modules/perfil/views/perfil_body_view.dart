import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/login_view.dart';
import 'package:flutter_loggin_firebase/app/modules/perfil/views/perfil_image_view.dart';
import 'package:get/get.dart';

import 'perfil_menu_view.dart';

// ignore: use_key_in_widget_constructors
class PerfilBodyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const PerfilImageView(),
          const SizedBox(height: 20),
          ProfileMenuView(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => {},
          ),
          ProfileMenuView(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {},
          ),
          ProfileMenuView(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {},
          ),
          ProfileMenuView(
            text: "Help Center",
            icon: "assets/icons/Question mark.svg",
            press: () {},
          ),
          ProfileMenuView(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () => Get.to(() => LoginView()),
          ),
        ],
      ),
    );
  }
}
