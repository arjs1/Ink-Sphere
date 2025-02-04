import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ink_sphere/core/api/user_auth_api.dart';
import 'package:ink_sphere/core/provider/user_auth_data_provider.dart';
import 'package:ink_sphere/pages/LoginPage/widgets/input_text_field.dart';
import 'package:ink_sphere/pages/OtpPage/otp_page.dart';
import 'package:ink_sphere/pages/OtpPage/widgets/otp_box.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ForgetPasswordPage extends StatefulWidget {
  final String userDataEmail;
  const ForgetPasswordPage({super.key, required this.userDataEmail});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final verificationBool = Provider.of<UserAuthDataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: verificationBool.isverified
            ? SizedBox(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    Text(
                      "Enter Your New Password",
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    InputTextField(
                      controller: passwordController,
                      hinttext: "New password",
                      obscuretext: true,
                      validator: ValidationBuilder()
                          .maxLength(15)
                          .minLength(8)
                          .build(),
                    ),
                    InputTextField(
                      controller: confirmPasswordController,
                      hinttext: "confirm password",
                      obscuretext: true,
                      validator: ValidationBuilder()
                          .maxLength(15)
                          .minLength(8)
                          .build(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary),
                      child: MaterialButton(
                        onPressed: () {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            UserAuthApi().forgetPasswordChange(
                                passwordController.text, context);
                          }
                        },
                        child: Text(
                          "Confirm",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Enter OTP sent at",
                            style: GoogleFonts.poppins(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                              textAlign: TextAlign.center,
                              " ${widget.userDataEmail}",
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OtpBox(
                          // onSaved: onSaved,
                          controller: pin1,
                        ),
                        OtpBox(
                          // onSaved: onSaved,
                          controller: pin2,
                        ),
                        OtpBox(
                          // onSaved: onSaved,
                          controller: pin3,
                        ),
                        OtpBox(
                          // onSaved: onSaved,
                          controller: pin4,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            color: Theme.of(context).colorScheme.primary,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 40,
                            color: Theme.of(context).colorScheme.primary,
                            child: MaterialButton(
                              onPressed: () {
                                String otpCont = concat(
                                    pin1.text, pin2.text, pin3.text, pin4.text);
                                debugPrint(otpCont);
                                UserAuthApi()
                                    .forgetPasswordOtpVerify(
                                        otpCont, widget.userDataEmail, context)
                                    .then((_) {
                                  setState(() {});
                                });
                              },
                              child: Text("Confirm"),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
