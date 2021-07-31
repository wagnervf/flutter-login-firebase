import 'package:flutter_loggin_firebase/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_loggin_firebase/app/modules/home/views/home_view.dart';
import 'package:flutter_loggin_firebase/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/login_view.dart';
import 'package:flutter_loggin_firebase/app/modules/perfil/bindings/perfil_binding.dart';
import 'package:flutter_loggin_firebase/app/modules/perfil/views/perfil_view.dart';
import 'package:flutter_loggin_firebase/app/modules/splash/bindings/splash_binding.dart';
import 'package:flutter_loggin_firebase/app/modules/splash/views/splash_view.dart';
import 'package:flutter_loggin_firebase/app/modules/user/bindings/user_binding.dart';
import 'package:flutter_loggin_firebase/app/modules/user/views/user_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PERFIL,
      page: () => PerfilView(),
      binding: PerfilBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => UserView(),
      binding: UserBinding(),
    ),
  ];
}
