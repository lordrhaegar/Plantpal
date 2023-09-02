import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_app/screens/main_screen.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
Future<void> login(BuildContext context, String email, String password) async {
  try {
    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    String? authToken = await userCredential.user!.getIdToken();
    String userData = userCredential.user!.uid;
    print('Login successful: ${userCredential.user!.uid}');
    print("authToken: $authToken");
    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen(uid: userData)));
  } on FirebaseAuthException catch (e) {
    print('Login failed: $e');
            //   AwesomeDialog(
            //       context: context,
            //       dialogType: DialogType.error,
            //       animType: AnimType.rightSlide,
            //       title: 'Invalid Password',
            //       desc: '${e.message}',
            //       btnCancelOnPress: () {},
            // btnOkOnPress: () {},
            // ).show();
  }
}
Future<void> storeToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}
