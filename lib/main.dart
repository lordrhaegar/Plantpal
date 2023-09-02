import 'package:flutter/material.dart';
import 'package:plant_app/auth/authentication_wrapper.dart';
import 'package:plant_app/auth/biometric_auth.dart';
import 'package:plant_app/screens/cart_screen.dart';
import 'package:plant_app/screens/home_screen.dart';
import 'package:plant_app/screens/login_screen.dart';
import 'package:plant_app/screens/main_screen.dart';
import 'package:plant_app/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fingerprint_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const AuthenticationWrapper(),

      routes: {
        FingerprintScreen.id: (context) => const FingerprintScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        MainScreen.id: (context) => const MainScreen(uid: ''),
        HomeScreen.id: (context) => const HomeScreen(uid: ''),
        CartScreen.id: (context) => const CartScreen(),
      },
    );
  }
}
