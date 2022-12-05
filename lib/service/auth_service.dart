import 'package:firebase_auth/firebase_auth.dart';
import 'package:sugar_cubes/helper/help_func.dart';
import 'package:sugar_cubes/service/database_service.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future logInWithEmailPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future registerUserWithEmailPassword(String username, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        await DatabaseService(uid: user.uid).updateUserData(username, email);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    try {
      await HelperFunction.saveUserLogInStatus(false);
      await HelperFunction.saveUserName("");
      await HelperFunction.saveUserEmail("");

      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}