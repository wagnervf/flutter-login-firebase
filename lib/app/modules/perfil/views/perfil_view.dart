import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/buttom_nav_bar.dart';
import 'package:flutter_loggin_firebase/app/shared/enums.dart';
import 'package:get/get.dart';

import '../controllers/perfil_controller.dart';
import 'perfil_body_view.dart';

// ignore: use_key_in_widget_constructors
class PerfilView extends GetView<PerfilController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PerfilView'),
        centerTitle: true,
      ),
      body: PerfilBodyView(),
      bottomNavigationBar: const BottomNavBar(
        selectedMenu: MenuState.profile,
      ),
    );
  }
}
