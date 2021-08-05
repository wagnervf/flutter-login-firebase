import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/home/views/home_view.dart';
import 'package:flutter_loggin_firebase/app/modules/perfil/views/perfil_view.dart';
import 'package:flutter_loggin_firebase/app/shared/enums.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    const Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -15),
            blurRadius: 20,
            color: const Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            iconHome(inActiveIconColor),
            iconCalendar(inActiveIconColor),
            iconList(inActiveIconColor),
            iconProfile(inActiveIconColor),
          ],
        ),
      ),
    );
  }

  IconButton iconProfile(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.person_fill,
        color: MenuState.profile == selectedMenu
            ? kPrimaryColor
            : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => PerfilView(),
      ),
    );
  }

  IconButton iconList(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.list_bullet,
        color:
            MenuState.list == selectedMenu ? kPrimaryColor : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => HomeView(),
      ),
    );
  }

  IconButton iconCalendar(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.calendar,
        color: MenuState.calendar == selectedMenu
            ? kPrimaryColor
            : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => HomeView(),
      ),
    );
  }

  IconButton iconHome(Color inActiveIconColor) {
    return IconButton(
      icon: Icon(
        CupertinoIcons.house_fill,
        color:
            MenuState.home == selectedMenu ? kPrimaryColor : inActiveIconColor,
      ),
      onPressed: () => Get.to(
        () => HomeView(),
      ),
    );
  }
}
