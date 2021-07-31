import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/default_button.dart';
import 'package:flutter_loggin_firebase/app/modules/home/views/home_view.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:get/get.dart';

class LoginSuccessView extends StatelessWidget {
  const LoginSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: const Text(''),
          ),
      body: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getHeight(context) * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: getHeight(context) * 0.4, //40%
        ),
        SizedBox(height: getHeight(context) * 0.08),
        const Text(
          "Login Success",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: getHeight(context) * 0.6,
            child: DefaultButton(
              text: "Back to home",
              press: () {
                Get.to(() => HomeView());
              },
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
