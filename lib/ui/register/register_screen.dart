import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hire_me/models/registration_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/auth_service.dart';
import '../../utils/color_resources.dart';
import '../../utils/firebase_auth_services.dart';
import '../../utils/toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final passwordFocusNode = FocusNode();
  final mobileFocusNode = FocusNode();

  final companyPasswordFocusNode = FocusNode();
  final companyMobileFocusNode = FocusNode();
  String registerType = "";
  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  bool isSigningUp = false;

  // final FirebaseAuthService _auth = FirebaseAuthService();

  //for employee
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  //for company
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _businessNumberController =
      TextEditingController();
  final TextEditingController _businessEmailController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _companyPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    getRegisterType();
  }

  Future<void> getRegisterType() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      registerType = (prefs.getString('registerType'))!;
    });
  }

  void _signUp() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isSigningUp = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;
    String username = _fullNameController.text;
    String mobile = _mobileNumberController.text;
    String companyName = _companyNameController.text;
    String businessEmail = _businessEmailController.text;
    String companyPassword = _companyPasswordController.text;
    String businessNumber = _businessNumberController.text;
    String address = _addressController.text;

    RegistrationResponse? registrationResponse = await _authService.register(
        email,
        password,
        username,
        mobile,
        businessEmail,
        companyPassword,
        companyName,
        businessNumber,
        address,
        registerType);

    setState(() {
      isSigningUp = false;
    });
    if (registrationResponse?.status == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('loginDone', false);
      await prefs.setString('token', registrationResponse!.accessToken!);
      showToast(message: "User is successfully signed in");
      if (context.mounted) {
        context.pushReplacement("/home");
      }
    } else {
      showToast(message: "${registrationResponse?.msg}");
    }
  }

  void _toggleObscured(bool isPassword) {
    setState(() {
      if (isPassword) {
        _passwordObscured = !_passwordObscured;
        if (!passwordFocusNode.hasPrimaryFocus) {
          passwordFocusNode.canRequestFocus = false;
        }
      } else {
        _confirmPasswordObscured = !_confirmPasswordObscured;
        if (!mobileFocusNode.hasPrimaryFocus) {
          mobileFocusNode.canRequestFocus = false;
        }
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hintText, HeroIcons icon,
      {bool isPassword = false}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle:
          const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
      prefixIcon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
        child: HeroIcon(icon),
      ),
      prefixIconConstraints: const BoxConstraints(maxHeight: 26, maxWidth: 26),
      suffixIconConstraints: const BoxConstraints(maxHeight: 26, maxWidth: 26),
      suffixIcon: isPassword
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: GestureDetector(
                onTap: () => _toggleObscured(hintText == "Password"),
                child: HeroIcon(
                  hintText == "Password"
                      ? (_passwordObscured ? HeroIcons.eye : HeroIcons.eyeSlash)
                      : (_confirmPasswordObscured
                          ? HeroIcons.eye
                          : HeroIcons.eyeSlash),
                  size: 24,
                ),
              ),
            )
          : null,
    );
  }

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
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _signUp();
    } else {
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 350.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200.h,
                        child: FadeInUp(
                          duration: const Duration(seconds: 1),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/light-1.png'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150.h,
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 1200),
                          child: Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png'))),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150.h,
                        child: FadeInUp(
                            duration: const Duration(milliseconds: 1300),
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 1600),
                          child: Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Center(
                              child: registerType == "employee"
                                  ? Text(
                                      "Let's create your Business account.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )
                                  : Text(
                                      "Let's create your account.",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30.sp,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30)
                          .r,
                  child: Column(
                    children: <Widget>[
                      FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: Form(
                          key: _formKey,
                          child: registerType == "jobs"
                              ? Column(
                                  children: [
                                    TextFormField(
                                      controller: _fullNameController,
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      textInputAction: TextInputAction.next,
                                      decoration: _inputDecoration(
                                          "Full Name", HeroIcons.user),
                                    ),
                                    15.verticalSpace,
                                    TextFormField(
                                      controller: _mobileNumberController,
                                      keyboardType: TextInputType.phone,
                                      focusNode: mobileFocusNode,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      decoration: _inputDecoration(
                                          "Mobile number", HeroIcons.phone,
                                          isPassword: false),
                                    ),
                                    15.verticalSpace,
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      decoration: _inputDecoration(
                                          "Email address", HeroIcons.envelope),
                                      validator: _emailValidator,
                                    ),
                                    15.verticalSpace,
                                    TextFormField(
                                      controller: _passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: _passwordObscured,
                                      focusNode: passwordFocusNode,
                                      decoration: _inputDecoration(
                                          "Password", HeroIcons.lockClosed,
                                          isPassword: true),
                                      validator: _passwordValidator,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    TextFormField(
                                      controller: _companyNameController,
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      textInputAction: TextInputAction.next,
                                      decoration: _inputDecoration(
                                          "Company Name", HeroIcons.user),
                                    ),
                                    15.verticalSpace,
                                    TextFormField(
                                      controller: _businessNumberController,
                                      keyboardType: TextInputType.phone,
                                      focusNode: companyMobileFocusNode,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      decoration: _inputDecoration(
                                          "Business number", HeroIcons.phone,
                                          isPassword: false),
                                    ),
                                    15.verticalSpace,
                                    TextFormField(
                                      controller: _businessEmailController,
                                      keyboardType: TextInputType.emailAddress,
                                      textInputAction: TextInputAction.next,
                                      decoration: _inputDecoration(
                                          "Business email", HeroIcons.envelope),
                                      validator: _emailValidator,
                                    ),
                                    15.verticalSpace,
                                    TextFormField(
                                      controller: _companyPasswordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: _passwordObscured,
                                      focusNode: companyPasswordFocusNode,
                                      decoration: _inputDecoration(
                                          "Password", HeroIcons.lockClosed,
                                          isPassword: true),
                                      validator: _passwordValidator,
                                    ),
                                    15.verticalSpace,
                                    TextFormField(
                                      controller: _addressController,
                                      keyboardType: TextInputType.text,
                                      decoration: _inputDecoration(
                                          "Address", HeroIcons.mapPin,
                                          isPassword: false),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      50.verticalSpace,
                      FadeInUp(
                        duration: const Duration(milliseconds: 1900),
                        child: GestureDetector(
                          onTap: _submitForm,
                          child: Container(
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.r),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      30.verticalSpace,
                      FadeInUp(
                        duration: const Duration(milliseconds: 2000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            3.horizontalSpace,
                            GestureDetector(
                              onTap: () {
                                context.pushReplacement('/login');
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color:
                                        const Color.fromRGBO(143, 148, 251, 1)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (isSigningUp)
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
