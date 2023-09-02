import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


Future<bool> updateUserData(
    String uid,
    String username,
    String fullName,
    String address,
    ) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'full_Name': fullName,
      'username': username,
      'address': address,
    });
    return true; // Success
  } catch (e) {
    print('Error updating user data: $e');
    return false; // Failure
  }
}


