import 'dart:ui';
import 'package:bigcart_ecommerce_app/Providers/auth_provider.dart';
import 'package:bigcart_ecommerce_app/Providers/user_provider.dart';
import 'package:bigcart_ecommerce_app/Screens/Signup_Screen.dart';
import 'package:bigcart_ecommerce_app/Widgets/RaisedGradientButton.dart';
import 'package:bigcart_ecommerce_app/Widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../Utility/Validator.dart';
import 'Home_Screen.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  bool isRemember = false;
  bool isPasswordHidden = false;
  bool isProgressLoading = false;
  String? _email_address, _password;
  final loginformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Auth_Provider authProvider = Provider.of<Auth_Provider>(context);
    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
            child: SizedBox.expand(
                child: FittedBox(
              fit: BoxFit.cover,
              child: Image.asset('assets/images/login_auth_img.png'),
            )),
          ),
          Positioned(
              child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 17, right: 26),
                child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => onback(context),
                        child: const Icon(Icons.west, color: Colors.white))),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30, left: 80),
                child: Text("Welcome",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white)),
              ),
            ],
          )),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xffF4F5F9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: SingleChildScrollView(
            child: Form(
              key: loginformKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.06),
                      const Text("Welcome back !",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5)),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                          width: MediaQuery.of(context).size.width * 0.06),
                      const Text("Sign in to your account",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.5,
                              color: Color(0xff868889))),
                    ],
                  ),
                  const SizedBox(height: 27),
                  custom_textfield(
                      inputDecoration: const InputDecoration(
                          prefixIcon: Image(
                              image: AssetImage('assets/images/email_icon.png'),
                              height: 18,
                              width: 18),
                          suffixIconColor: Colors.white,
                          hintText: "Email Address",
                          hintStyle: TextStyle(
                              color: Color(0xFF868889),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.5),
                          border: InputBorder.none),
                      fieldValidator: (value) => validateEmail(value),
                      onsaved: (newValue) => _email_address = newValue),
                  const SizedBox(height: 5),
                  custom_textfield(
                    inputDecoration: InputDecoration(
                        prefixIcon: const Image(
                            image: AssetImage('assets/images/lock_icon.png'),
                            height: 18,
                            width: 18),
                        suffixIcon: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(100),
                            onTap: () => onpasswordtoggle(),
                            child: const Image(
                                image:
                                    AssetImage('assets/images/eye_icon.png')),
                          ),
                        ),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                            color: Color(0xFF868889),
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5),
                        border: InputBorder.none),
                    obscure_txt: isPasswordHidden,
                    onsaved: (newValue) => _password = newValue,
                    fieldValidator: (value) => validatePassword(value),
                  ),
                  Row(
                    children: [
                      const SizedBox(height: 25, width: 20),
                      Switch(
                        activeColor: Theme.of(context).primaryColorDark,
                        inactiveThumbColor: Theme.of(context).primaryColorLight,
                        value: isRemember,
                        onChanged: (value) {
                          setState(() => isRemember = value);
                          authProvider.isRemember = isRemember;
                        },
                      ),
                      const Text("Remember me",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                              color: Color(0xff868889))),
                      const Spacer(),
                      Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => forgotpassword_press(),
                            child: const Text("Forgot password",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                    color: Color(0xff407EC7))),
                          )),
                      const SizedBox(height: 25, width: 20),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
                      authProvider.isLoading
                          ? CircularProgressIndicator(
                              color: Theme.of(context).primaryColorDark)
                          : RaisedGradientButton(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.9,
                              margin_left: 17,
                              margin_right: 17,
                              child: const Text("Login",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 1)),
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  Color(0xffAEDC81),
                                  Color(0xff6CC51D)
                                ],
                              ),
                              onPressed: () =>
                                  onlogin_press(context, authProvider),
                            ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t have an account ? ",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                              color: Color(0xff868889))),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => onsignup_press(),
                          child: const Text("Sign up",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                  color: Colors.black)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onback(BuildContext context) {
    Navigator.of(context).pop();
  }

  onlogin_press(BuildContext context, Auth_Provider authProvider) {
    final form = loginformKey.currentState!;
    if (form.validate()) {
      form.save();
      final Future<Map<String, dynamic>> loginresponse =
          authProvider.getUserLoggedIn(_email_address!, _password!);
      loginresponse.then((value) {
        if (value['Isloggedin']) {
          Provider.of<User_Provider>(context, listen: false).setUser(value['User']);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successfully!")));
          Future.delayed(
              const Duration(seconds: 1),
              () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const Home_Screen())));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text("Message ${value['Message']}")),
          );
        }
      });
    }
  }

  onpasswordtoggle() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  onsignup_press() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => const Signup_Screen()));
  }

  forgotpassword_press() {}
}
