import 'package:flutter/material.dart';

import '../theme.dart';
import 'decorations.dart';

class Componentsutils {
  // static Container builLabelValor() {
  //   return Container(
  //     padding: const EdgeInsets.all(4.0),
  //     alignment: Alignment.topLeft,
  //     child: const Text(
  //       'Valor',
  //       textAlign: TextAlign.left,
  //     ),
  //   );
  // }

  static Container buildInputValor(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Valor",
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextFormField(
            controller: controller,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: inputDecorationValor(),
          ),
        ],
      ),
    );
  }

  static InputDecoration inputDecorationValor() {
    return const InputDecoration(
      contentPadding: EdgeInsets.all(5),
    );
  }

  static InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      prefixIcon: const Icon(Icons.description_outlined),
      prefixIconConstraints: const BoxConstraints(
        minHeight: 52,
        minWidth: 32,
      ),
      hintText: hintText,
      contentPadding: const EdgeInsets.all(25),
      filled: true,
    );
  }
}
