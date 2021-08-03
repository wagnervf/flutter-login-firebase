import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/login_componentes.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

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

  bool _passwordVisible = true;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Acessar'),
          ),
      body: SingleChildScrollView(child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Informe seu e-mail e senha para acessar',
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: getHeight(context) * .08),
              buildTextFormFieldEmail(),
              SizedBox(height: getHeight(context) * .02),
              buildTextFormFieldSenha(),
              SizedBox(height: getHeight(context) * .01),
              LoginComponentes.esqueceuSenha(),
              SizedBox(height: getHeight(context) * .08),
              buttonAcessar(context),
              SizedBox(height: getHeight(context) * .02),
              LoginComponentes.naoPossuiConta(),
            ],
          ),
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

  TextFormField buildTextFormFieldEmail() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "E-mail",
        hintText: "digite seu e-mail",
        suffixIcon: Icon(Icons.email_outlined),
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
      keyboardType: TextInputType.text,
      controller: _password,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: 'Senha',
        hintText: 'Digite sua senha',
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
      validator: Validatorless.multiple(
        [
          Validatorless.required('A Senha é obrigatória'),
          Validatorless.min(4, 'A Senha precida ter no mínimo 4 carateres'),
        ],
      ),
    );
  }
}
