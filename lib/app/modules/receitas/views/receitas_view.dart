import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/Listas/list_contas.dart';
import 'package:flutter_loggin_firebase/app/components/Listas/list_despesas.dart';
import 'package:flutter_loggin_firebase/app/components/Listas/list_receitas.dart';
import 'package:flutter_loggin_firebase/app/components/app_bar.dart';
import 'package:flutter_loggin_firebase/app/components/bottomSheet.dart';
import 'package:flutter_loggin_firebase/app/components/componentsUtils.dart';
import 'package:flutter_loggin_firebase/app/components/constants.dart';
import 'package:flutter_loggin_firebase/app/components/customSwitch.dart';
import 'package:flutter_loggin_firebase/app/components/decorations.dart';
import 'package:flutter_loggin_firebase/app/components/order_button.dart';
import 'package:flutter_loggin_firebase/app/components/select_date.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'package:get/get.dart';

import '../controllers/receitas_controller.dart';

class ReceitasView extends GetView<ReceitasController> {
  final titles = ["List 1", "List 2", "List 3"];
  final subtitles = [
    "Here is list 1 subtitle",
    "Here is list 2 subtitle",
    "Here is list 3 subtitle"
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];
  final TextEditingController controlValor =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final TextEditingController _controlDescricao = TextEditingController();
  final isSwitched = true;
  final isSwitchedC = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kColorReceitas,
      appBar: AppBarCustom(title: 'Receitas', color: kColorReceitas),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [buildHeaderReceitas(size), buildBodyReceitas(size)],
        ),
      )),
    );
  }

  Container buildHeaderReceitas(Size size) {
    return Container(
      color: kColorReceitas,
      height: size.height * .15,
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Componentsutils.buildInputValor(controlValor),
    );
  }

  Container buildBodyReceitas(Size size) {
    return Container(
      decoration: Decorations.boxDecorationCircular(),
      height: size.height * .75,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 10),
          CustomSwitch(
            icon: Icons.check_circle,
            label: 'Pago',
            isSwitched: isSwitched,
          ),
          const Divider(),
          //Data
          SelectDate(),
          const Divider(),
          ListReceitas(),
          const Divider(),
          ListContas(),
          const Divider(),

          //Campo Descição

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              controller: _controlDescricao,
              cursorColor: kColorReceitas,
              decoration: Componentsutils.buildInputDecoration('Descrição'),
            ),
          ),

          const Divider(),

          ButtonSalvar(
            size: size,
            color: kColorReceitas,
            press: () {},
          ),

          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
