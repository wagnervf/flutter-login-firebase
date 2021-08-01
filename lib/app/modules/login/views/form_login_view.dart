import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import 'forgot_password_view.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';

class FormLoginView extends StatefulWidget {
  const FormLoginView({Key? key}) : super(key: key);

  @override
  _FormLoginViewState createState() => _FormLoginViewState();
}

class _FormLoginViewState extends State<FormLoginView> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getHeight(context) * .03),
          buildTextFormFieldEmail(),
          SizedBox(height: getHeight(context) * .02),
          buildTextFormFieldSenha(),
          SizedBox(height: getHeight(context) * .01),
          esqueceuSenha(),
          SizedBox(height: getHeight(context) * .02),
          buttonAcessar(context),
        ],
      ),
    );
  }

  SizedBox buttonAcessar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getHeight(context) * .07,
      child: Obx(
        () => ElevatedButton(
          onPressed: () => _submit(_formKey),
          child: loginController.loading
              ? builLoading()
              : Text(
                  'Acessar',
                  style: TextStyle(
                    fontSize: getHeight(context) * .03,
                    color: Colors.white,
                  ),
                ),
          style: styleElevatedButton(),
        ),
      ),
    );
  }

  _submit(_formKey) {
    var formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      loginController.loginInFirebase(
        email: _email.text,
        password: _password.text,
      );
    }
  }

  TextFormField buildTextFormFieldEmail() {
    return TextFormField(
      decoration: defaultInputDecoration(
        "E-mail",
        "Digite seu e-mail",
        Icons.email_outlined,
      ),
      style: const TextStyle(
        fontSize: 18,
        decoration: TextDecoration.none,
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _email,
      validator: Validatorless.multiple(
        [
          Validatorless.required('E-mail é obrigatório'),
          Validatorless.email('Email é inválido'),
        ],
      ),
    );
  }

  TextFormField buildTextFormFieldSenha() {
    return TextFormField(
        decoration: defaultInputDecoration(
          "Senha",
          "Digite sua senha",
          Icons.lock_outlined,
        ),
        obscureText: true,
        controller: _password,
        validator: Validatorless.multiple([
          Validatorless.required('A Senha é obrigatória'),
          Validatorless.min(4, 'A Senha precida ter no mínimo 4 carateres'),
        ]));
  }

  Row esqueceuSenha() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          'Esqueceu a senha? ',
          style: TextStyle(fontSize: 16.0),
        ),
        TextButton(
          onPressed: () => Get.to(() => ForgotPasswordView()),
          child: Text(
            'clique aqui',
            style: stylelLink2(),
          ),
        ),
      ],
    );
  }
}
