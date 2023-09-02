import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../screens/main_screen.dart';
import '../screens/login_screen.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedToken = prefs.getString('token');
    if (storedToken != null) {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<String?> getIDToken() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String? idToken = await user.getIdToken();
      return idToken;
    } else {
      return ''; // Return an empty string if user is not authenticated
    }
  }
  String? getUidFromIdToken(String idToken) {
    try {
      final Map<String, dynamic> decodedToken = Jwt.parseJwt(idToken);
      final uid = decodedToken['sub'];
      return uid;
    } catch (e) {
      print('Error decoding ID token: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return CircularProgressIndicator(); // Show loading indicator
    } else {
      return FutureBuilder<String?>(
        future: getIDToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while waiting for ID token
          } else if (snapshot.hasData && snapshot.data != null) {
            print(snapshot.data);
            String? uid = getUidFromIdToken(snapshot.data!);
            return MainScreen(uid: uid!);
          } else {
            return LoginScreen();
          }
        },
      );
    }
  }
}


