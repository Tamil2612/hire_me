import 'package:animate_do/animate_do.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hire_me/ui/login/widgets/bear_log_in_controller.dart';
import 'package:hire_me/ui/login/widgets/sign_up_modal.dart';
import 'package:hire_me/ui/login/widgets/signin_button.dart';
import 'package:hire_me/ui/login/widgets/tracking_text_input.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/auth_service.dart';
import '../../models/user_model.dart';
import '../../utils/color_resources.dart';
import '../../utils/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isSigning = false;
  late BearLoginController _bearLoginController;
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

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

  openBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return const SizedBox(
          height: 200,
          child: SignUpModal(),
        );
      },
    );
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

    LoginResponse? loginResponse = await _authService.login(email, password);

    setState(() {
      isSigning = false;
    });

    if (loginResponse != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loginDone', true);
      await prefs.setString('token', loginResponse.accessToken!);
      showToast(message: "User is successfully signed in");
      if (context.mounted) {
        context.pushReplacement("/home");
      }
    } else {
      showToast(message: "Invalid credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets devicePadding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(93, 142, 155, 1.0),
      body: Stack(
        alignment: Alignment.center,
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
                  left: 20.w, right: 20.w, top: devicePadding.top + 50.w),
              child: FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Login to your account.",
                      style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                        height: 200.h,
                        padding: EdgeInsets.only(left: 30.w, right: 30.w),
                        child: FlareActor(
                          "assets/animation/Teddy.flr",
                          shouldClip: false,
                          alignment: Alignment.bottomCenter,
                          fit: BoxFit.contain,
                          controller: _bearLoginController,
                        )),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30.w),
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
                                isPasswordField:
                                true, // This enables the show/hide password functionality
                              ),
                              SigninButton(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.white),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    _signIn();
                                  }
                                },
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "You don't have an account yet?",
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      openBottomSheet();
                                      // context.pushReplacement('/register');
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: const Color.fromRGBO(
                                              143, 148, 251, 1)),
                                    ),
                                  ),
                                ],
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
