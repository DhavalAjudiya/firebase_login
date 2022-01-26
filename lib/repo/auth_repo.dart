import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_app/constant/const.dart';
import 'package:flutter/material.dart';

class AuthRepo {
  static Future registrationRepo({String? email, String? pass}) async {
    try {
      await kFirebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: pass!);
    } catch (e) {
      print('register error =>$e');
    }
  }

  static Future<bool?> loginRepo({String? email, String? pass}) async {
    try {
      await kFirebaseAuth.signInWithEmailAndPassword(
          email: email!, password: pass!);
      return true;
    } catch (e) {
      print('login error =>$e');
      return false;
    }
  }

  static currentUser() {
    print('user email ==>> ${kFirebaseAuth.currentUser!.email}');
    print('user id ==>> ${kFirebaseAuth.currentUser!.uid}');
  }

  static logOut() {
    kFirebaseAuth.signOut();
  }

  static deleteuseraccount(
      {String? email, String? pass, BuildContext? context}) async {
    User? user = kFirebaseAuth.currentUser;

    AuthCredential credential =
        EmailAuthProvider.credential(email: email!, password: pass!);

    await user!.reauthenticateWithCredential(credential).then((value) {
      value.user!.delete().then((res) {
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            content: Text("User Account Deleted"),
          ),
        );
      });
    }).catchError((onError) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("Credential Error"),
        ),
      );
    });
  }

  static sendpasswordresetemail({String? email, BuildContext? context}) async {
    await kFirebaseAuth.sendPasswordResetEmail(email: email!).then((value) {
      // Get.offAll(LoginPage());
      // Get.snackbar("Password Reset email link is been sent", "Success");
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("Password Reset email link is been sent"),
        ),
      );
    }).catchError((onError) {
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text("Error In Email Reset"),
        ),
      );
    });
  }
}
