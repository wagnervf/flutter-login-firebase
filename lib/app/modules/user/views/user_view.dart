import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';

import 'package:get/get.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UserView'), centerTitle: true),
      body: loggedInWidget(context),
    );
  }

  Widget loggedInWidget(BuildContext context) {
    final user = loginController.userFirebase[0];
    final logged = loginController.userLogged;

    return Center(
      child: logged
          ? Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .5,
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('${user.photoURL}')),
                  const SizedBox(height: 32),
                  Text('${user.displayName}', style: TextStyle(fontSize: 20)),
                  Text('${user.email}'),
                  Text('emailVerified: ${user.emailVerified.toString()}'),
                  Text(user.uid),
                  const SizedBox(height: 32),
                  TextButton(
                    onPressed: () => loginController.setLogoutAll(),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            )
          : const Text('Not user logged in Firebase!'),
    );
  }
}
