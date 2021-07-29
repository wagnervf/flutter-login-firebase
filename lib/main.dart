import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/login_view.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/routes/app_pages.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     GetMaterialApp(
//       home: LoginView(),
//       bi
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      title: 'Login Firebase',
      // theme: UfmsTheme,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: LoginBinding(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
