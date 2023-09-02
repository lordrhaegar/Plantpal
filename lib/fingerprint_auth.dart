import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:plant_app/auth/authentication_wrapper.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/screens/login_screen.dart';
import 'package:plant_app/screens/main_screen.dart';

class FingerprintScreen extends StatefulWidget {
  const FingerprintScreen({Key? key}) : super(key: key);
  static const String id = 'FingerprintScreen';
  @override
  _FingerprintScreenState createState() => _FingerprintScreenState();
}

class _FingerprintScreenState extends State<FingerprintScreen> {
  @override
  void initState() {
    super.initState();
    _authenticate();
  }
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _authenticate() async {
    bool isAuthenticated = false;
    try {
      isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Scan Your Fingerprint',
        //
        // biometricOnly: true,
        // useErrorDialogs: true,
        // stickyAuth: true,
      );
    } catch (e) {
      print("Error: $e");
    }

    if (isAuthenticated) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthenticationWrapper()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Scan Your Fingerprint'),
      ),
    );
  }
}