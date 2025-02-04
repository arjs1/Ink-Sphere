import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ink_sphere/core/api/user_auth_api.dart';
import 'package:ink_sphere/pages/ForgetPasswordPage/forget_password_page.dart';
import 'package:ink_sphere/pages/LoginPage/widgets/input_text_field.dart';
import 'package:ink_sphere/pages/SignupPage/signup_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final forgetEmailController = TextEditingController();

  final passwordController = TextEditingController();
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "LOGIN",
            style: TextStyle(
              letterSpacing: 8.0,
              fontSize: 25,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    image: DecorationImage(
                      opacity: 0.2,
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/login.jpg"),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "InkSphere",
                      style: GoogleFonts.amaticSc(
                        fontSize: 50,
                        letterSpacing: 6.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    // InputTextField(
                    //     controller: widget.usernameController,
                    //     validator: ValidationBuilder().maxLength(10).build(),
                    //     hinttext: "username",
                    //     obscuretext: false),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    InputTextField(
                        controller: widget.emailController,
                        validator:
                            ValidationBuilder().email().maxLength(50).build(),
                        // controller: "",
                        hinttext: "Email",
                        obscuretext: false),
                    SizedBox(
                      height: 30,
                    ),
                    InputTextField(
                      controller: widget.passwordController,
                      validator: ValidationBuilder()
                          .maxLength(15)
                          .minLength(8)
                          .build(),
                      hinttext: "Password",
                      obscuretext: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => ForgetPasswordPage(),
                            //   ),
                            // );
                            showDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: AlertDialog(
                                    // title: Text(
                                    //   "Invalid OTP",
                                    //   style: TextStyle(color: Colors.black),
                                    // ),
                                    content: InputTextField(
                                      controller: widget.forgetEmailController,
                                      hinttext: "Enter your email",
                                      obscuretext: false,
                                      validator: ValidationBuilder()
                                          .email()
                                          .maxLength(50)
                                          .build(),
                                    ),
                                    actions: [
                                      Container(
                                        // width: 50,
                                        height: 50,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: TextButton(
                                          child: Text(
                                            "Discard",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: TextButton(
                                          child: Text(
                                            "OK",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            UserAuthApi().forgetPasswordOtpSend(
                                                widget.forgetEmailController
                                                    .text);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgetPasswordPage(
                                                  userDataEmail: widget
                                                      .forgetEmailController
                                                      .text,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            // textAlign: TextAlign.end,
                            "Forget Password?",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary),
                      child: MaterialButton(
                        onPressed: () {
                          UserAuthApi().loginUser(
                              context,
                              widget.emailController.text,
                              widget.passwordController.text);
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()),
                          );
                        },
                        child: Text("Don't have an account? SignUp"))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
