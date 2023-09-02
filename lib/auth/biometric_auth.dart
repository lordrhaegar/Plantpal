import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:plant_app/auth/authentication_wrapper.dart';
import '../fingerprint_auth.dart';

class BiometricCheck extends StatefulWidget {
  const BiometricCheck({super.key});

  @override
  _BiometricCheckState createState() => _BiometricCheckState();
}

class _BiometricCheckState extends State<BiometricCheck> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> checkBiometric() async {
    bool hasBiometric = false;
    try {
      hasBiometric = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      print("Error checking biometric availability: $e");
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
        hasBiometric ? FingerprintScreen() : AuthenticationWrapper(),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    checkBiometric();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

    throw UnimplementedError();
  }
}
