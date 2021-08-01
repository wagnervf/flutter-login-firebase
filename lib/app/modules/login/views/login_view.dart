import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/nao_possui_conta.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import 'form_login_view.dart';

// ignore: use_key_in_widget_constructors
class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    //  var size = MediaQuery.of(context).size;
    final loginController = Get.put(LoginController());
    final logged = loginController.userLogged;

    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logged
                ? Text(loginController.userFirebase[0].email!)
                : Text('Não Logado'),
            const FlutterLogo(size: 130),
            builBemVindo(
              'Seja Bem Vindo!',
              'Acesse com sua conta ou crie uma nova',
            ),
            SizedBox(height: getHeight(context) * 0.03),
            const FormLoginView(),
            SizedBox(height: getHeight(context) * 0.02),
            buildNaoPossuiConta(possuiConta: true),
            SizedBox(height: getHeight(context) * 0.02),
          ],
        ),
      ),
    );
  }

  TextStyle buildTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle buildTextLogin() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    );
  }
}
