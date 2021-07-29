import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/form_view.dart';
import 'package:flutter_loggin_firebase/app/modules/user/views/user_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../controllers/login_controller.dart';
import 'google_sign_in_provider.dart';

class LoginView extends GetView<LoginController> {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(
      () => Visibility(
        visible: !loginController.userLogged,
        child: signUpWidget(),
        replacement: buidLogged(),
      ),
    );
  }

  Container buidLogged() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Text('${loginController.userFirebase[0].uid}')),
          TextButton(
            onPressed: () => Get.to(() => UserView()),
            child: const Text('Profile'),
          ),
          TextButton(
            onPressed: () => loginController.setLogoutAll(),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget signUpWidget() {
    return ListView(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 32),
            const Text("Você não está conectado"),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () => Get.to(() => FormView()),
              child: const Text('Criar Conta'),
            ),
            const SizedBox(height: 32),
            GoogleSignInProvider(),
          ],
        ),
      ],
    );
  }
}
