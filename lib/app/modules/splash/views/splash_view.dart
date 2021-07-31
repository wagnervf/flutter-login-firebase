import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';
import 'body_splash.dart';

// ignore: use_key_in_widget_constructors
class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    ///
    SizeConfig().init(context);

    ///
    return Scaffold(body: BodySplash());
  }
}
