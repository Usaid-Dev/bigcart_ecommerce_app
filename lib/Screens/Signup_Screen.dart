import 'package:bigcart_ecommerce_app/Screens/Home_Screen.dart';
import 'package:bigcart_ecommerce_app/Utility/Validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/auth_provider.dart';
import '../Providers/user_provider.dart';
import '../Widgets/RaisedGradientButton.dart';
import '../Widgets/custom_textfield.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({Key? key}) : super(key: key);

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  bool isPasswordHidden = false;
  String? _email, _password, _phonenumber;
  final signupformkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Auth_Provider authProvider = Provider.of<Auth_Provider>(context);
    return Scaffold(
        body: Stack(
          children: [
            FractionallySizedBox(
              child: SizedBox.expand(child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset('assets/images/signup_img.png'),
              )
              ),
            ),
            Positioned(
                child: Row(children: [
                Padding(padding: const EdgeInsets.only(top: 30, left: 17, right: 26),
                  child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () => onback(context),
                          child: const Icon(Icons.west, color: Colors.white)
                      )
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30, left: 80),
                  child: Text("Welcome", style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white)
                  ),
                ),
              ],
                )
            )
          ],
        ),
        bottomNavigationBar: Padding(padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.56,
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
                  key: signupformkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                              width: MediaQuery.of(context).size.width * 0.06),
                          const Text("Create account",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.5)
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                              width: MediaQuery.of(context).size.width * 0.06),
                          const Text("Quickly create account", style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 1.5, color: Color(0xff868889)
                          )
                          ),
                        ],
                      ),
                      const SizedBox(height: 27),
                      custom_textfield(
                        inputDecoration: const InputDecoration(
                            prefixIcon: Image(
                                image: AssetImage('assets/images/email_icon.png')),
                            suffixIconColor: Colors.white,
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                color: Color(0xFF868889),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.5),
                            border: InputBorder.none),
                        txt_input_type: TextInputType.emailAddress,
                        fieldValidator: (value) => validateEmail(value),
                        onsaved: (newValue) => _email = newValue,
                      ),
                      const SizedBox(height: 5),
                      custom_textfield(
                        inputDecoration: const InputDecoration(
                            prefixIcon: Image(
                                image: AssetImage('assets/images/telephone_icon.png')
                            ),
                            suffixIconColor: Colors.white,
                            hintText: "Phone Number",
                            hintStyle: TextStyle(color: Color(0xFF868889),
                                fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 1.5),
                            border: InputBorder.none),
                        txt_input_type: TextInputType.phone,
                        fieldValidator: (value) => validatePhoneNumber(value),
                        onsaved: (newValue) => _phonenumber = newValue,
                      ),
                      const SizedBox(height: 5),
                      custom_textfield(
                        inputDecoration: InputDecoration(
                            prefixIcon: const Image(
                                image: AssetImage('assets/images/lock_icon.png'),
                                height: 18),
                            suffixIcon: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: () => onpasswordtoggle(),
                                child: const Image(
                                    image: AssetImage('assets/images/eye_icon.png')
                                ),
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
                        fieldValidator: (value) => validatePassword(value),
                        onsaved: (newValue) => _password = newValue,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.017),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          authProvider.isLoading
                              ? CircularProgressIndicator(
                                  color: Theme.of(context).primaryColorDark)
                              : RaisedGradientButton(
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  margin_left: 17,
                                  margin_right: 17,
                                  child: const Text("Signup", style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 1)
                                  ),
                                  gradient: const LinearGradient(
                                    colors: <Color>[
                                      Color(0xffAEDC81),
                                      Color(0xff6CC51D)
                                    ],
                                  ),
                                  onPressed: () =>
                                      onsignup_press(context, authProvider),
                                )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account ? ",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,
                                  letterSpacing: 1, color: Color(0xff868889)
                              )
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => onlogin_press(context),
                              child: const Text("Login",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,
                                      letterSpacing: 1, color: Colors.black)
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }

  onback(BuildContext context) {
    Navigator.of(context).pop();
  }

  onsignup_press(BuildContext context, Auth_Provider authProvider) {
    final form = signupformkey.currentState!;
    if (form.validate()) {
      form.save();
      final Future<Map<String, dynamic>> loginresponse =
          authProvider.getUserSignedUp(_email!, _phonenumber!, _password!);
      loginresponse.then((value) {
        if (value['isSignedup']) {
          Provider.of<User_Provider>(context, listen: false)
              .setUser(value['User']);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Signup Successfully!")));
          Future.delayed(
               const Duration(seconds: 1),
              () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const Home_Screen())
              )
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text("Message ${value['Message']}")
            ),
          );
        }
      }
      );
    }
  }

  onlogin_press(BuildContext context) {
    Navigator.of(context).pop();
  }

  onpasswordtoggle() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }
}
