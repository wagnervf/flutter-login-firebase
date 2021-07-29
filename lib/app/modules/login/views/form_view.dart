import 'package:flutter/material.dart';
import 'package:flutter_loggin_firebase/app/modules/login/controllers/login_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class FormView extends StatefulWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  FormViewState createState() {
    return FormViewState();
  }
}

class FormViewState extends State<FormView> {
  final loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();
  final _scallfoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scallfoldKey,
      appBar: AppBar(
        title: const Text('FormView'),
        centerTitle: true,
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            width: 300.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => Container(
                    alignment: Alignment.center,
                    width: 300,
                    child: loginController.loading
                        ? const Center(child: CircularProgressIndicator())
                        : buttonSubmit(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton buttonSubmit() {
    return ElevatedButton.icon(
      label: const Text('Submit'),
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Colors.black,
        minimumSize: const Size(200, 50),
      ),
      icon: const FaIcon(
        FontAwesomeIcons.checkCircle,
        color: Colors.greenAccent,
      ),
      onPressed: () {
        Map<String, dynamic> userData = {
          "name": _nameController.text,
          "email": _emailController.text,
        };

        loginController.createUserFirebase(
          userData: userData,
          password: _passwordController.text,
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
