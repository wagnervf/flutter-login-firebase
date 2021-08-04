import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/home/views/home_view.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/login_view.dart';
import 'package:flutter_loggin_firebase/app/modules/user/controllers/user_controller.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController controller;
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      return _getUser();
    });

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _getUser() {
    setState(() {});
    //var user = FirebaseAuth.instance.currentUser;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.off(() => HomeView());
      } else {
        Get.off(() => LoginView());
      }
    });

    // if (user != null) {
    //   Get.off(() => HomeView());
    // } else {
    //   Get.off(() => LoginView());
    // }
  }

  Widget _body() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SizedBox(
            height: getHeight(context) * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(size: getHeight(context) * .2),
                SizedBox(
                  height: getHeight(context) * .1,
                  width: getHeight(context) * .1,
                  child: CircularProgressIndicator(
                    value: controller.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
