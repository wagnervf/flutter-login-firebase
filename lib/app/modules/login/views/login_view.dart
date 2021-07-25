import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/form_view.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginView'),
        centerTitle: true,
      ),
      body: FormView(),
    );
  }

  Container loginContainer() {
    return Container(
      child: Text(
        'LoginView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
