import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/login_componentes.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4.0),
            margin: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterLogo(size: getHeight(context) * .1),
                  LoginComponentes.builBemVindo(
                    'Seja Bem Vindo!',
                    'Informe seu usuário e senha.',
                  ),
                  SizedBox(height: getHeight(context) * 0.1),
                  buildTextFormFieldEmail(),
                  buildTextFormFieldSenha(),
                  LoginComponentes.esqueceuSenha(),
                  buttonAcessar(context),
                  Divider(
                    height: getHeight(context) * 0.05,
                  ),
                  SizedBox(height: getHeight(context) * 0.08),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text('ou acesse com'),
                  ),
                  LoginComponentes.buttonGoogle(),
                  LoginComponentes.naoPossuiConta(),
                  LoginComponentes.buidTermos(context)
                ],
              ),
            ),
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
              ? showLoading()
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
        prefixIcon: Icon(Icons.email_outlined),
        labelText: "E-mail",
        hintText: "digite seu e-mail",
        // suffixIcon: Icon(Icons.email_outlined),
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
        prefixIcon: Icon(Icons.lock_outline),
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
