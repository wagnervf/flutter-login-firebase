import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/nao_possui_conta.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_loggin_firebase/app/services/validators_custom.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class FormCadastroView extends StatefulWidget {
  const FormCadastroView({Key? key}) : super(key: key);

  @override
  _FormCadastroViewState createState() => _FormCadastroViewState();
}

class _FormCadastroViewState extends State<FormCadastroView> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmaPassword = TextEditingController();

  @override
  void dispose() {
    _nome.dispose();
    _email.dispose();
    _password.dispose();
    _confirmaPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  SizedBox _body(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const Text('Cadastrar uma conta', style: headerStyle),
                SizedBox(height: getHeight(context) * .03),
                const Text(
                  'Por favor, informe seu dados \npara o cadastro da conta.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getHeight(context) * .05),
                buildTextFormFieldNome(),
                SizedBox(height: getHeight(context) * .03),
                buildTextFormFieldEmail(),
                SizedBox(height: getHeight(context) * .03),
                buildTextFormFieldSenha(),
                SizedBox(height: getHeight(context) * .02),
                buildTextFormFieldConfirmaSenha(),
                SizedBox(height: getHeight(context) * .03),
                buttonCadastrar(context),
                SizedBox(height: getHeight(context) * .03),
                buildNaoPossuiConta(possuiConta: false),
                SizedBox(height: getHeight(context) * .02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buttonCadastrar(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getHeight(context) * .07,
      child: ElevatedButton(
        onPressed: () => _submit(_formKey),
        child: loginController.loading
            ? const Center(child: CircularProgressIndicator())
            : Text(
                'Cadastrar',
                style: TextStyle(
                  fontSize: getHeight(context) * .03,
                  color: Colors.white,
                ),
              ),
        style: ElevatedButton.styleFrom(
          primary: kPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  _submit(_formKey) {
    var formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      Map<String, dynamic> userData = {
        "name": _nome.text,
        "email": _email.text,
      };

      loginController.createUserFirebase(
        userData: userData,
        password: _password.text,
      );
    }
  }

  TextFormField buildTextFormFieldNome() {
    return TextFormField(
      decoration: defaultInputDecoration(
        "Nome",
        "Digite seu nome",
        Icons.person_add_alt_outlined,
      ),
      controller: _nome,
      validator: Validatorless.required('Nome é obrigatório'),
    );
  }

  TextFormField buildTextFormFieldEmail() {
    return TextFormField(
        decoration: defaultInputDecoration(
          "E-mail",
          "Digite seu e-mail",
          Icons.email_outlined,
        ),
        keyboardType: TextInputType.emailAddress,
        controller: _email,
        validator: Validatorless.multiple([
          Validatorless.required('E-mail é obrigatório'),
          Validatorless.email('Email é inválido'),
        ]));
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

  TextFormField buildTextFormFieldConfirmaSenha() {
    return TextFormField(
        decoration: defaultInputDecoration(
          "Confirmar a senha",
          "Digite novamente sua senha",
          Icons.lock_outlined,
        ),
        obscureText: true,
        controller: _confirmaPassword,
        validator: Validatorless.multiple([
          Validatorless.required('A confirmação da senha é obrigatória'),
          Validatorless.min(
              4, 'A confirmação da senha precida ter no mínimo 4 carateres'),
          ValidatorsCustom.compare(_password, 'As senhas não conferem')
        ]));
  }
}
