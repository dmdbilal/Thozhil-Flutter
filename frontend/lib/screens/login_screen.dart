import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thozhil_flutter_app/screens/dashboard_screen.dart';
import 'package:thozhil_flutter_app/screens/signup_screen.dart';
import 'package:thozhil_flutter_app/services/auth_service.dart';
import 'package:thozhil_flutter_app/util/user_preferences.dart';
import 'package:thozhil_flutter_app/util/util_functions.dart';

import '../model/user.model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible=false;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    passwordVisible=true;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;

    var assetsImage = const AssetImage('assets/thozhil_logo.png');
    var image = Image(image: assetsImage, fit: BoxFit.cover, height: 50);

    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        body: Center(
          child: Column(children: [
            Flexible(
              flex: 2, // 20% of the screen
              child: Container(
                color: Colors.white,
                child: Center(
                  child: image,
                ),
              ),
            ),
            Flexible(
              flex: 8, // 80% of the screen
              child: ClipRRect(
                borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(100.0)),
                child: Container(
                    padding: const EdgeInsets.all(30),
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      maxWidth: maxWidth,
                      maxHeight: maxHeight,
                    ),
                    color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('LOGIN',
                            style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == "") {
                                      return "Enter your email !";
                                    }
                                    return null;
                                  },
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email',
                                  ),
                                  focusNode: _emailFocusNode,
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(_passFocusNode);
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == "") {
                                      return "Enter your password !";
                                    }
                                    return null;
                                  },
                                  focusNode: _passFocusNode,
                                  obscureText: passwordVisible,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(
                                              () {
                                            passwordVisible = !passwordVisible;
                                          },
                                        );
                                      },
                                    )
                                  ),

                                ),
                              ),
                              const SizedBox(height: 20),

                              Container(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Text("Forgot password ?",
                                        style: TextStyle(color: Colors.white70)),
                                  ))
                            ],
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                var response = await AuthService.loginUser(_emailController.text, _passwordController.text);
                                if (response['status']) {
                                  await UserPreferences.setLoggedIn(true);
                                  await UserPreferences.setToken(response['token']);
                                  await UserPreferences.setUser(response['existingUser']);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const DashboardScreen()));
                                } else {
                                  scaffoldMessengerKey.currentState?.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          response['message'],
                                          style: dmSansStyle(
                                              15,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.center
                                      ),
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30)
                                      )
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                fixedSize: Size(maxWidth / 3, 50)),
                            child: Text("Login",
                                style: GoogleFonts.dmSans(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterScreen(title: 'SIGN UP')),
                              );
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(color: Colors.white70),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ],
                    )),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
