import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_loggin_firebase/app/modules/home/views/home_view.dart';
import 'package:flutter_loggin_firebase/app/modules/user/controllers/user_controller.dart';
import 'package:flutter_loggin_firebase/app/modules/user/model/user_model.dart';
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

  final Rxn<User?> _firebaseUser = Rxn<User>();

  final _userFirebase = <User>[].obs;
  final _logged = false.obs;
  final _loading = false.obs;

  User get firebaseUser => _firebaseUser.value!;

  List<User> get userFirebase => _userFirebase;
  bool get userLogged => _logged.value;
  bool get loading => _loading.value;

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
    /*
    ever(_userFirebase, (_) {
      userIsLogged();
    });
  */
    super.onInit();
  }

  //Criar usuário no Firebase e salvar ele na colletions
  //
  Future createUserFirebase({
    required Map<String, dynamic> userData,
    required String password,
  }) async {
    try {
      setLoading(true);
      Future.delayed(const Duration(seconds: 1), () async {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userData["email"],
          password: password,
        );

        UserModel _user = UserModel.fromDocumentCreate(
          doc: userCredential.user,
          name: userData["displayName"],
        );

        if (await _saveUserInCollectionFirebase(_user)) {
          Get.find<UserController>().user = _user;
          setLoading(false);
          loginSucess();
        }
      });
    } on FirebaseAuthException catch (e) {
      loginError();
      return HandleErros.getErroCreateUserFireabse(e);
    } catch (e) {
      loginError();
    }
  }

  //Login Firebase
  //
  Future loginInFirebase(
      {required String email, required String password}) async {
    try {
      setLoading(true);
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      //
      //buscado o usuário que foi salvo no BD
      Get.find<UserController>().user =
          await _getUsuarioInColletion(result.user!.uid);
      loginSucess();

      //
    } on FirebaseAuthException catch (error) {
      loginError();
      return HandleErros.getErroLoginFireabse(error);
    } catch (e) {
      loginError();
    }
  }

  //Login Google
  //
  Future loginGoogle() async {
    try {
      setLoading(true);
      Future.delayed(const Duration(seconds: 1), () async {
        final currentUserGoogle = await googleSignIn.signIn();

        if (currentUserGoogle == null) return;

        final googleAuth = await currentUserGoogle.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        UserModel _user =
            UserModel.fromDocumentSnapshotGoogle(currentUserGoogle);

        if (await _saveUserInCollectionFirebase(_user)) {
          Get.find<UserController>().user = _user;
          setLoading(false);
          loginSucess();
        }

        setUserGoogleInFirebase(credential);
        loginSucess();
      });
    } catch (error) {
      print(error);
      print('Não foi possível realizar o login');
    }
  }

  //Gravar o usuário do google nos usuários do Firebase
  //
  void setUserGoogleInFirebase(AuthCredential credential) async {
    try {
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      loginSucess();
    } on FirebaseAuthException catch (e) {
      print(e);

      loginError();
    }
  }

  // Salva usuário no banco do firebase
  //
  Future<bool> _saveUserInCollectionFirebase(UserModel userData) async {
    try {
      await firestore.collection("users").doc(userData.uid).set({
        "displayName": userData.displayName,
        "email": userData.email,
        "emailVerified": userData.emailVerified,
        "isAnonymous": userData.isAnonymous,
        "photoURL": userData.photoURL,
        "providerId": userData.providerId,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //buscar usuário banco do firebase
  //
  Future<UserModel> _getUsuarioInColletion(String uid) async {
    var user;
    try {
      return await firestore.collection("users").doc(uid).get().then((value) {
        if (value.exists) {
          user = UserModel.fromDocumentSnapshot(value.data());
        }
        return user;
      });
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  void loginSucess() {
    //setLogged(true);
    //setUserFirebase(value.user!);
    setLoading(false);
    Get.to(() => HomeView());
  }

  void loginError() {
    setLoading(false);
    setLogged(false);
    clearUser();
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
    try {
      setLogged(true);
      await _auth.signOut();
      Get.find<UserController>().clear();
      Get.to(() => LoginView());
      clearUser();
      setLogged(false);
      userData = {};
    } catch (e) {
      Get.snackbar("Erro signing out", e.toString());
    }
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

// Future<bool> _saveUserInCollectionFirebase(
//       Map<String, dynamic> userData) async {
//     try {
//       this.userData = userData;
//       await firestore
//           .collection("users")
//           .doc(_userFirebase[0].uid)
//           .set(userData);
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
