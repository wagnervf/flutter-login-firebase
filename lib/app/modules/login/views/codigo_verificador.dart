import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/components/default_button.dart';
import 'package:flutter_loggin_firebase/app/shared/size_config.dart';
import 'package:flutter_loggin_firebase/app/theme.dart';

class CodigoVerificador extends StatefulWidget {
  const CodigoVerificador({Key? key}) : super(key: key);

  @override
  _CodigoVerificadorState createState() => _CodigoVerificadorState();
}

class _CodigoVerificadorState extends State<CodigoVerificador> {
  // final _formKey = GlobalKey<FormState>();
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: getHeight(context) * .05),
                const Text('OTP Verification', style: headerStyle),
                const Text('We sent you code to +55 67 9988 ***'),
                buildMensagem(),
                SizedBox(height: getHeight(context) * .1),
                Form(
                  child: Column(
                    children: [
                      buildInputsCodigos(context),
                      SizedBox(height: getHeight(context) * 0.2),
                      DefaultButton(
                        text: "Continue",
                        press: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(height: getHeight(context) * .15),
                GestureDetector(
                  onTap: () {
                    // OTP code resend
                  },
                  child: const Text(
                    "Resend OTP Code",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Row buildMensagem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("O código expirará em "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0),
          duration: const Duration(seconds: 30),
          builder: (context, value, child) => Text(
            "00:$value",
            textAlign: TextAlign.center,
            style: const TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {},
        )
      ],
    );
  }

  Row buildInputsCodigos(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: getWidth(context) * .2,
          child: TextFormField(
            autofocus: true,
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
            decoration: otpInputDecoration,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              nextField(value: value, focusNode: pin2FocusNode);
            },
          ),
        ),
        SizedBox(
          width: getWidth(context) * .2,
          child: TextFormField(
            focusNode: pin2FocusNode,
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
            decoration: otpInputDecoration,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              nextField(value: value, focusNode: pin3FocusNode);
            },
          ),
        ),
        SizedBox(
          width: getWidth(context) * .2,
          child: TextFormField(
            focusNode: pin3FocusNode,
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
            decoration: otpInputDecoration,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              nextField(value: value, focusNode: pin4FocusNode);
            },
          ),
        ),
        SizedBox(
          width: getWidth(context) * .2,
          child: TextFormField(
            focusNode: pin4FocusNode,
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
            decoration: otpInputDecoration,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              pin4FocusNode.unfocus();
            },
          ),
        ),
      ],
    );
  }
}
