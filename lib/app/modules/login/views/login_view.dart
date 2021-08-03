import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/login_componentes.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

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
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FlutterLogo(size: getHeight(context) * .2),
            SizedBox(height: getHeight(context) * 0.07),
            LoginComponentes.builBemVindo(
              'Seja Bem Vindo!',
              'Acesse com sua conta ou crie uma nova',
            ),
            SizedBox(height: getHeight(context) * 0.07),
            LoginComponentes.buttonLogin(),
            SizedBox(height: getHeight(context) * 0.01),
            LoginComponentes.naoPossuiConta(),
            SizedBox(height: getHeight(context) * 0.03),
            const Text('ou acesse com', textAlign: TextAlign.center),
            SizedBox(height: getHeight(context) * 0.01),
            LoginComponentes.buttonGoogle(),
            SizedBox(height: getHeight(context) * 0.03),
            LoginComponentes.buttonFacebook(),
            SizedBox(height: getHeight(context) * 0.07),
            LoginComponentes.buidTermos(context)
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
