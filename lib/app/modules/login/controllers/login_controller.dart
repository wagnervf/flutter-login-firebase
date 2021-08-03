import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_loggin_firebase/app/modules/home/views/home_view.dart';
import 'package:flutter_loggin_firebase/app/services/handle_erros.dart';

import 'package:flutter_loggin_firebase/app/modules/login/views/login_view.dart';
import 'package:flutter_loggin_firebase/app/modules/user/views/user_view.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  GoogleSignInAccount? currentUserGoogle;

  GoogleSignIn googleSignIn = GoogleSignIn();
  Map<String, dynamic> userData = {};

  final _userFirebase = <User>[].obs;
  final _logged = false.obs;
  final _loading = false.obs;

  List<User> get userFirebase => _userFirebase;
  bool get userLogged => _logged.value;
  bool get loading => _loading.value;

  @override
  void onInit() {
    //  userIsLogged();
    /*
    ever(_userFirebase, (_) {
      userIsLogged();
    });
*/
    super.onInit();
  }

  //
  //Login Google
  //
  void setUserGoogleInFirebase(AuthCredential credential) async {
    try {
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      loginSucess(authResult);
    } on FirebaseAuthException catch (e) {
      print(e);

      loginError();
    }
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

      loginSucess(userCredential);
      await _saveUserInFirebase(userData);
    } on FirebaseAuthException catch (e) {
      HandleErros.getErroCreateUserFireabse(e);
      loginError();
    } catch (e) {
      loginError();
    }
  }

  //
  //Login Firebase
  //
  Future loginInFirebase(
      {required String email, required String password}) async {
    try {
      setLoading(true);
      //  userIsLogged();
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      loginSucess(result);
      //
    } on FirebaseAuthException catch (error) {
      loginError();
      return HandleErros.getErroLoginFireabse(error);
    } catch (e) {
      loginError();
    }
  }

  Future loginGoogle() async {
    try {
      // googleSignIn!.signInSilently();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      currentUserGoogle = googleUser;

      final googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      setUserGoogleInFirebase(credential);
      loginSucess(credential);
    } catch (error) {
      print(error);
      print('Não foi possível realizar o login');
    }
  }

  void loginSucess(value) {
    setLogged(true);
    setUserFirebase(value.user!);
    setLoading(false);
    Get.to(() => HomeView());
  }

  void loginError() {
    setLoading(false);
    setLogged(false);
    clearUser();
  }

  Future _saveUserInFirebase(Map<String, dynamic> userData) async {
    this.userData = userData;
    await firestore.collection("users").doc(_userFirebase[0].uid).set(userData);
  }

  void setLoading(bool val) {
    _loading.value = val;
  }

  void setUserFirebase(user) {
    if (user != null) {
      _userFirebase.add(user);
      _userFirebase.refresh();
    }
  }

  void setLogged(bool value) {
    _logged.value = value;
    _logged.refresh();
  }

  void setLogoutAll() async {
    //
    await FirebaseAuth.instance.signOut();
    Get.to(() => LoginView());
    clearUser();
    setLogged(false);
    userData = {};
  }

  void logoutGoogle() async {
    await googleSignIn.disconnect();
    setLogoutAll();
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
