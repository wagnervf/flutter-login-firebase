import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_loggin_firebase/app/services/handle_erros.dart';
import 'package:flutter_loggin_firebase/app/services/messages_snackbar.dart';

import 'package:flutter_loggin_firebase/app/modules/login/views/login_view.dart';
import 'package:flutter_loggin_firebase/app/modules/user/views/user_view.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();
  Map<String, dynamic> userData = {};

  final _userFirebase = <User>[].obs;
  final _logged = false.obs;
  final _loading = false.obs;

  //late User userCreatedFirebase;
  //Rx<User> _userCreatedFirebase;
  //get userFirestore => _userCreatedFirebase;

  List<User> get userFirebase => _userFirebase;
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

      setLogged(true);
      setUserFirebase(userCredential.user!);
      await _saveUserInFirebase(userData);

      setLoading(false);
      //
    } on FirebaseAuthException catch (e) {
      HandleErros.getErroCreateUserFireabse(e);
      setLoading(false);
      setLogged(false);
      //
    } catch (e) {
      setLoading(false);
      setLogged(false);
      //
    }
  }

  //
  //Login Firebase
  //
  loginInFirebase({required String email, required String password}) async {
    try {
      setLoading(true);
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      setLogged(true);
      setUserFirebase(result.user!);
      setLoading(false);

      //
    } on FirebaseAuthException catch (error) {
      setLoading(false);
      setLogged(false);
      return HandleErros.getErroLoginFireabse(error);
    } catch (e) {
      setLoading(false);
      setLogged(false);
      print('catch: ${e}');
      //
    }
  }

  Future _saveUserInFirebase(Map<String, dynamic> userData) async {
    this.userData = userData;
    await firestore.collection("users").doc(_userFirebase[0].uid).set(userData);
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
    userData = {};
    //Get.to(() => LoginView());
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
