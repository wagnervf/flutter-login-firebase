import 'package:flutter_loggin_firebase/app/components/Listas/list_contas.dart';
import 'package:flutter_loggin_firebase/app/components/Listas/list_despesas.dart';
import 'package:flutter_loggin_firebase/app/components/Listas/list_receitas.dart';
import 'package:flutter_loggin_firebase/app/components/select_date.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import '../controllers/despesas_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/app_bar.dart';
import 'package:flutter_loggin_firebase/app/components/bottomSheet.dart';
import 'package:flutter_loggin_firebase/app/components/componentsUtils.dart';
import 'package:flutter_loggin_firebase/app/components/constants.dart';
import 'package:flutter_loggin_firebase/app/components/customSwitch.dart';
import 'package:flutter_loggin_firebase/app/components/decorations.dart';
import 'package:flutter_loggin_firebase/app/components/order_button.dart';

class DespesasView extends GetView<DespesasController> {
  final TextEditingController controlValor =
      MoneyMaskedTextController(leftSymbol: 'R\$ ');
  final TextEditingController _controlDescricao = TextEditingController();
  final isSwitched = true;
  final isSwitchedC = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kColorDespesas,
      appBar: AppBarCustom(title: 'Despesas', color: kColorDespesas),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeaderDespesas(size),
            buildBodyDespesas(size),
          ],
        ),
      )),
    );
  }

  Container buildHeaderDespesas(Size size) {
    return Container(
      color: kColorDespesas,
      height: size.height * .15,
      width: double.infinity,
      alignment: Alignment.topCenter,
      child: Componentsutils.buildInputValor(controlValor),
    );
  }

  Container buildBodyDespesas(Size size) {
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
          ListDespesas(),
          const Divider(),
          ListContas(),
          const Divider(),

          //Campo Descição

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              controller: _controlDescricao,
              cursorColor: Colors.redAccent,
              decoration: Componentsutils.buildInputDecoration('Descrição'),
            ),
          ),

          const Divider(),

          ButtonSalvar(
            size: size,
            color: kColorDespesas,
            press: () {},
          ),

          const SizedBox(height: 10)

          // CustomSwitch(label: 'Dinheiro', isSwitched: isSwitched),
          //  CustomSwitch(label: 'Cartão Débito', isSwitched: isSwitchedC),
          // CustomSwitch(label: 'Cartão Crédito', isSwitched: isSwitchedC),
          // Bottomsheet(
          //   label: 'Fundo Retirado',
          //   titles: titles2,
          //   subtitles: subtitles2,
          //   icons: icons,
          //   iconList: Icons.account_balance_wallet_outlined,
          // ),
          // Componentsutils.inputTextDefault(_controlDescricao, 'Conta'),
        ],
      ),
    );
  }
}
