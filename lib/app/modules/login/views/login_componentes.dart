import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/forgot_password_view.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/form_cadastro_view.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/login_view.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginComponentes {
  LoginComponentes._();

  static Row esqueceuSenha() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Esqueceu a senha? ',
          style: TextStyle(fontSize: 14.0),
        ),
        TextButton(
          onPressed: () => Get.to(() => ForgotPasswordView()),
          child: Text(
            'clique aqui',
            style: stylelLink2(),
          ),
        ),
      ],
    );
  }

  static Row naoPossuiConta() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Não possui conta? ',
          style: TextStyle(fontSize: 16.0),
        ),
        TextButton(
          onPressed: () => Get.to(() => const FormCadastroView()),
          child: Text(
            'Clique aqui',
            style: stylelLink(),
          ),
        ),
      ],
    );
  }

  static Container buidTermos(BuildContext context) {
    return Container(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => {},
                child: const Text('Termo de Uso'),
              ),
              TextButton(
                onPressed: () => {},
                child: const Text('Termo de Privacidade'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Container buttonLogin() {
    return Container(
      padding: EdgeInsets.zero,
      width: double.infinity,
      child: ElevatedButton.icon(
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Acessar com o E-mail',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: kTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(200, 45),
            elevation: 2.0),
        icon: const FaIcon(
          FontAwesomeIcons.envelope,
          color: kTextColor,
        ),
        onPressed: () => {Get.to(() => LoginView())},
      ),
    );
  }

  static Container buttonGoogle() {
    final loginController = Get.put(LoginController());
    return Container(
      padding: EdgeInsets.zero,
      width: double.infinity,
      child: Obx(() => ElevatedButton.icon(
            label: loginController.loading
                ? showLoading()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Acessar com o Google',
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            style: ElevatedButton.styleFrom(
              primary: Colors.redAccent,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              minimumSize: const Size(200, 45),
            ),
            icon: const FaIcon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
            onPressed: () => loginController.loginGoogle(),
          )),
    );
  }

  // static Container buttonFacebook() {
  //   return Container(
  //     padding: EdgeInsets.zero,
  //     width: double.infinity,
  //     child: ElevatedButton.icon(
  //       label: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Text(
  //             'Acessar com o Facebook',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //             textAlign: TextAlign.center,
  //           ),
  //         ],
  //       ),
  //       style: ElevatedButton.styleFrom(
  //         primary: const Color(0xFF1877f2),
  //         onPrimary: Colors.white,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         minimumSize: const Size(200, 45),
  //       ),
  //       icon: const FaIcon(
  //         FontAwesomeIcons.facebookF,
  //         color: Colors.white,
  //       ),
  //       onPressed: () => {},
  //     ),
  //   );
  // }

  static Column builBemVindo(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle,
        ),
        Text(
          subtitle,
          style: subTitleLightStyle,
        ),
      ],
    );
  }
}
