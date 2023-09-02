
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/screens/home_screen.dart';

import '../screens/main_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> registerWithEmailAndPassword(
    BuildContext context,
    String email,
    String password,
    String fullName,
    String gender,
    String username,
    String age,
    String address
    ) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userUid = userCredential.user!.uid;
    print(userUid);

    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'full_Name': fullName,
      'email': email,
      'address': address,
      'age': age,
      'gender': gender,
      'username': username
    });
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MainScreen(uid: userUid)));
  } catch (e) {
    print('Error during registration: $e');
  }
}
