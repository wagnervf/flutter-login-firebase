import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_loggin_firebase/app/modules/components/messages_snackbar.dart';
import 'package:flutter_loggin_firebase/app/modules/login/views/login_view.dart';
import 'package:flutter_loggin_firebase/app/modules/user/views/user_view.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();
  Map<String, dynamic> userData = Map();

  final _userFirebase = <User>[].obs;
  final _logged = false.obs;
  final _loading = false.obs;

  //late User userCreatedFirebase;
  //final userCreatedFirebase = <User>[].obs;
  //RxList<User> get userFirestore => userCreatedFirebase;

  RxList<User> get userFirebase => _userFirebase;
  bool get userLogged => _logged.value;
  bool get loading => _loading.value;

  //
  //Login Google
  //
  void setUserGoogleInFirebase(AuthCredential credential) async {
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    final User? user = authResult.user;

    setUserFirebase(user);
    setLogged(true);

    Get.to(() => UserView());
  }

  //
  //CreateUser WithEmailAndPassword Firebase
  //
  void createUserFirebase({
    required Map<String, dynamic> userData,
    required String password,
  }) async {
    try {
      setLoading(true);

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userData["email"],
        password: password,
      );

      setUserFirebase(userCredential.user!);
      await _saveUserInFirebase(userData);
      setLogged(true);
      setLoading(false);
      //
    } on FirebaseAuthException catch (e) {
      getErroCreateUserFireabse(e);
      setLoading(false);
      setLogged(false);
      //
    } catch (e) {
      setLoading(false);
      setLogged(false);
      print(e);
      //
    }
  }

  Future _saveUserInFirebase(Map<String, dynamic> userData) async {
    this.userData = userData;
    await firestore.collection("users").doc(_userFirebase[0].uid).set(userData);
  }

  getErroCreateUserFireabse(FirebaseAuthException error) {
    if (error.code == 'weak-password') {
      MessagesSnackbar.show('A senha fornecida é muito fraca.');
    } else if (error.code == 'email-already-in-use') {
      MessagesSnackbar.show('Este email já está em uso em outra conta');
    }
  }

  void setLoading(bool val) {
    _loading.value = val;
  }

  void setUserFirebase(user) {
    _userFirebase.add(user);
    _userFirebase.refresh();
  }

  void setLogged(bool value) {
    _logged.value = value;
    _logged.refresh();
  }

  void setLogoutAll() async {
    // await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    clearUser();
    setLogged(false);
    userData = Map();
    Get.to(() => LoginView());
  }

  void clearUser() {
    _userFirebase.clear();
    _userFirebase.refresh();
  }
}

// FirebaseAuth.instance.authStateChanges().listen((user) {
//   setState(() {
//     loginController.setUserFirebase(user);
//   });
// });
