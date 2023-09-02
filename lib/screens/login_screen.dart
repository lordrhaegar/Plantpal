import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plant_app/components/authentication_button.dart';
import 'package:plant_app/components/custom_text_field.dart';
import 'package:plant_app/components/curve.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/main_screen.dart';
import 'package:plant_app/screens/signup_screen.dart';
import '../auth/login_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  String username = '';
  String password = '';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void _submitLoginForm(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;
    login(context, email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.bottomRight,
        fit: StackFit.expand,
        children: [
          // First Child in the stack

          ClipPath(
            clipper: ImageClipper(),
            child: Image.asset(
              'images/leaves.jpg',
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
            ),
          ),

          Positioned(
            top: 30.0,
            left: 20.0,
            child: CircleAvatar(
              backgroundColor: kDarkGreenColor,
              radius: 22.0,
              backgroundImage: const AssetImage('images/IMG-20230814-WA0040.jpg'),
            ),
          ),

          // Second Child in the stack
          Positioned(
            height: MediaQuery.of(context).size.height * 0.67,
            width: MediaQuery.of(context).size.width,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.67,
                      maxWidth: MediaQuery.of(context).size.width,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // First Column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome Back',
                              style: GoogleFonts.poppins(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w600,
                                color: kDarkGreenColor,
                              ),
                            ),
                            Text(
                              'Login to your account',
                              style: GoogleFonts.poppins(
                                color: kGreyColor,
                                fontSize: 15.0,
                              ),
                            )
                          ],
                        ),

                        // Second Column
                        Column(
                          children: [
                            CustomTextField(
                              hintText: 'Email',
                              icon: Icons.person,
                              keyboardType: TextInputType.name,
                              controller: emailController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid Email';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                username = value != '' ? value : '';
                              },
                            ),
                            CustomTextField(
                              hintText: 'Password',
                              icon: Icons.lock,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: passwordController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid password';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                password = value != '' ? value : '';
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        checkColor: Colors.white,
                                        fillColor: MaterialStateProperty.all(
                                            kDarkGreenColor),
                                        value: rememberMe,
                                        onChanged: (value) {
                                          setState(() {
                                            rememberMe = value!;
                                          });
                                        },
                                      ),
                                      Text(
                                        'Remember Me',
                                        style: TextStyle(
                                          color: kGreyColor,
                                          fontSize: 14.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all(
                                          kDarkGreenColor),
                                    ),
                                    child: const Text(
                                      'Forgot Password ?',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Third Column
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            bottom: 20.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AuthenticationButton(
                                label: 'Log In',
                                onPressed: () {
                                  // if (username.toLowerCase() == 'admin' &&
                                  //     password == 'idk123!') {
                                  //   Navigator.pushNamed(context, MainScreen.id);
                                  // }
                                  _submitLoginForm(context);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Don\'t have an account ?',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                kDarkGreenColor),
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, SignupScreen.id);
                                      },
                                      child: const Text(
                                        'Sign up',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
