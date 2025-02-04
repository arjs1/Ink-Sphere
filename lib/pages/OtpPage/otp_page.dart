import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ink_sphere/core/api/user_auth_api.dart';
import 'package:ink_sphere/pages/OtpPage/widgets/otp_box.dart';

class OtpPage extends StatefulWidget {
  OtpPage({super.key});
  TextEditingController pin1 = TextEditingController();
  TextEditingController pin2 = TextEditingController();
  TextEditingController pin3 = TextEditingController();
  TextEditingController pin4 = TextEditingController();

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  void onSaved(String? value) {
    // Handle the saved value here
    debugPrint('OTP value saved: $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Verification Code",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "We have sent you the verification code",
                    style: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpBox(
                        // onSaved: onSaved,
                        controller: widget.pin1,
                      ),
                      OtpBox(
                        // onSaved: onSaved,
                        controller: widget.pin2,
                      ),
                      OtpBox(
                        // onSaved: onSaved,
                        controller: widget.pin3,
                      ),
                      OtpBox(
                        // onSaved: onSaved,
                        controller: widget.pin4,
                      ),
                    ],
                  ),
                ],
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
                              widget.pin1.text,
                              widget.pin2.text,
                              widget.pin3.text,
                              widget.pin4.text);
                          debugPrint(otpCont);
                          UserAuthApi().otpVerification(otpCont, context);
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

String concat(pin1, pin2, pin3, pin4) {
  String concated = pin1 + pin2 + pin3 + pin4;
  return concated;
}
