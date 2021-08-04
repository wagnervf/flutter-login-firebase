import 'package:flutter_loggin_firebase/app/modules/user/controllers/user_controller.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<UserController>(
      () => UserController(),
    );
  }
}
