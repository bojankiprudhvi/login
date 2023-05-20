import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/pages/login_page.dart';
import 'package:login/pages/welcome_page.dart';
import 'package:login/storage_methods.dart';
import 'package:login/utils/show_error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/user_model.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  //Authcontroller.instance..
  late Rx<User?> _user;
  //email,password,name
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar("About user", "User messsage",
          backgroundColor: Colors.redAccent,
          titleText: Text("Account creation failed",
              style: TextStyle(color: Colors.white)),
          messageText:
              Text(e.toString(), style: TextStyle(color: Colors.white)));
    }
  }

  // Signup User
  Future<String> signupUser({
    required BuildContext context,
    required String email,
    required String password,
    required String username,
    required Uint8List file,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential userCredentials =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //devtools.log(userCredentials.user!.uid.toString());

        final dawnloadUrlOfProfilePic =
            await StorageMethods().uploadImageToStorage(
          childName: "Profile Pics",
          file: file,
          isPost: false,
        );

        // Assigning to Model
        MyUser myUser = MyUser(
          email: email,
          uid: userCredentials.user!.uid,
          photoUrl: dawnloadUrlOfProfilePic,
          username: username,
          followers: [],
          following: [],
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(userCredentials.user!.uid)
            .set(myUser.toJson());
        res = "success";
      }

      return res;
    } on FirebaseAuthException catch (e) {
      //   devtools.log(e.toString());
      if (e.code == 'weak-password') {
        // devtools.log('The password provided is too weak.');
        await showErrorDialog(
          context,
          "Weak Password",
          "The password provided is too weak.",
        );
      } else if (e.code == 'email-already-in-use') {
        // devtools.log('The account already exists for that email.');
        await showErrorDialog(
          context,
          "Email Already in Use",
          "The account already exists for that email.",
        );
      } else if (e.code == "invalid-email") {
        // devtools.log("Invalid Email Address");
        await showErrorDialog(
          context,
          "Invalid Email Address",
          "Please Enter Correct Email Address it's Invalid",
        );
      }
      res = e.code;
      return res;
    } catch (e) {
      res = e.toString();
      return res;
    }
  }

  Future<String> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "success";
    } catch (e) {
      Get.snackbar("About Login", "Login messsage",
          backgroundColor: Colors.redAccent,
          titleText:
              Text("Login failed", style: TextStyle(color: Colors.white)),
          messageText:
              Text(e.toString(), style: TextStyle(color: Colors.white)));
      return "failed";
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
