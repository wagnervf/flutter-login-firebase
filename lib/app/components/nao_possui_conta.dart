import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/social_card.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/form_cadastro_view.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:get/get.dart';

Widget buildNaoPossuiConta({required bool possuiConta}) {
  return Column(
    children: [
      possuiConta
          ? Row(
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
            )
          : Container(),
      const SizedBox(height: 6.0),
      const Text('ou acesse com', textAlign: TextAlign.center),
      const SizedBox(height: 6.0),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialCard(
              icon: "assets/icons/google-icon.svg",
              press: () {},
            ),
            SocialCard(
              icon: "assets/icons/facebook-2.svg",
              press: () {},
            ),
          ],
        ),
      ),
    ],
  );
}
