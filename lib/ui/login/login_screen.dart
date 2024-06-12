import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hire_me/ui/login/widgets/bear_log_in_controller.dart';
import 'package:hire_me/ui/login/widgets/signin_button.dart';
import 'package:hire_me/ui/login/widgets/tracking_text_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/color_resources.dart';
import '../../utils/firebase_auth_services.dart';
import '../../utils/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  late BearLoginController _bearLoginController;
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _bearLoginController = BearLoginController();
    super.initState();
  }

  void _signIn() async {
    _passwordFocusNode.unfocus();
    setState(() {
      isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isSigning = false;
    });

    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loginDone', true);
      showToast(message: "User is successfully signed in");
      context.pushReplacement("/home");
    } else {
      showToast(message: "Some error occurred");
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(93, 142, 155, 1.0),
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.0, 1.0],
                  colors: [
                    Color.fromRGBO(143, 148, 251, 1),
                    Color.fromRGBO(143, 148, 251, .6),
                  ],
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: devicePadding.top + 50.0),
              child: FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Container(
                        height: 200,
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: FlareActor(
                          "assets/animation/Teddy.flr",
                          shouldClip: false,
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.contain,
                          controller: _bearLoginController,
                        )),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              TrackingTextInput(
                                label: "Email",
                                hint: "Enter your email address",
                                onCaretMoved: (Offset? caret) {
                                  _bearLoginController.coverEyes(caret == null);
                                  _bearLoginController.lookAt(caret);
                                },
                                textController: _emailController,
                                validator: _emailValidator,
                                focusNode: _emailFocusNode,
                              ),
                              TrackingTextInput(
                                label: "Password",
                                hint: "Enter your password",
                                isObscured: true,
                                focusNode: _passwordFocusNode,
                                onCaretMoved: (Offset? caret) {
                                  _bearLoginController.coverEyes(caret != null);
                                  _bearLoginController.lookAt(null);
                                },
                                onTextChanged: (String value) {
                                  _bearLoginController.setPassword(value);
                                },
                                textController: _passwordController,
                                validator: _passwordValidator,
                              ),
                              SigninButton(
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _signIn();
                                  }
                                },
                              ),
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTap: () {
                                  context.pushNamed('/register');
                                },
                                child: const Text(
                                  "New User? Sign Up",
                                  style: TextStyle(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isSigning)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                    color: ColorResources.primaryColor, size: 50),
              ),
            ),
        ],
      ),
    );
  }
}
