import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/default_button.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:get/get.dart';

// ignore: use_key_in_widget_constructors
class ForgotPasswordView extends StatefulWidget {
  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final List<String> erros = [];
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recuperar senha'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const Text(
                    'Esqueci a senha',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Por favor, informe seu e-mail \npara a recuperação da senha.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: getHeight(context) * 0.1),
                  buildTextFormFieldEmail(),
                  SizedBox(height: getHeight(context) * 0.1),
                  DefaultButton(
                    text: 'Enviar',
                    press: () {
                      // if (_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();
                      //   Get.to(() => const LoginSuccessView());
                      // }
                    },
                  ),
                  SizedBox(height: getHeight(context) * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormFieldEmail() {
    return TextFormField(
      onSaved: (newValue) => email = newValue!,
      decoration: const InputDecoration(
        labelText: "E-mail",
        hintText: "Digite seu e-mail",
        suffixIcon: Icon(Icons.email_outlined),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
