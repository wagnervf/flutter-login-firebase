import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/buttom_nav_bar.dart';
import 'package:flutter_loggin_firebase/app/components/constants.dart';
import 'package:flutter_loggin_firebase/app/modules/despesas/views/despesas_view.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_loggin_firebase/app/modules/receitas/views/receitas_view.dart';
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
    final size = MediaQuery.of(context).size;
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
              TextButton(
                onPressed: () => Get.to(() => DespesasView()),
                child: const Text('Despesas'),
              ),
              TextButton(
                onPressed: () => Get.to(() => ReceitasView()),
                child: const Text('Receitas'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cardReceita(size),
                  SizedBox(width: 8.0),
                  cardDespesa(size)
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedMenu: MenuState.home),
    );
  }

  Card cardDespesa(Size size) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: kColorDespesas,
          borderRadius: BorderRadius.circular(30),
        ),
        width: size.width * .45,
        height: size.height * .1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.trending_down,
              color: Colors.white,
              size: 32.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Despesas",
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  "R\$ 2569,39",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Card cardReceita(Size size) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: size.width * .45,
        height: size.height * .1,
        decoration: BoxDecoration(
          color: kColorReceitas,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.trending_up,
              color: Colors.white,
              size: 32.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Receitas",
                  style: TextStyle(color: Colors.white),
                ),
                const Text(
                  "R\$ 2569,39",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ],
            ),
          ],
        ),
      ),
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
