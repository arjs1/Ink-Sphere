import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ink_sphere/core/api/user_auth_api.dart';
import 'package:ink_sphere/pages/LoginPage/widgets/input_text_field.dart';

// ignore: must_be_immutable
class SignupPage extends StatefulWidget {
  SignupPage({super.key});
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController ageController = TextEditingController();

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final authAPi = UserAuthApi();
  String _selectedGender = 'male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "SIGNUP",
          style: TextStyle(
            letterSpacing: 8.0,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 15,
        children: [
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 80,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: InputTextField(
                  controller: widget.firstNameController,
                  hinttext: "First Name",
                  obscuretext: false,
                  validator: ValidationBuilder().minLength(0).build(),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: InputTextField(
                    controller: widget.lastNameController,
                    hinttext: "Last Name",
                    obscuretext: false,
                    validator: ValidationBuilder().minLength(0).build()),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Radio<String>(
                  value: 'male',
                  focusColor: Colors.black,
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary; // Color when selected
                    }
                    return Colors.grey; // Color when not selected
                  }),
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Male',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Radio<String>(
                  value: 'female',
                  focusColor: Colors.black,
                  fillColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Theme.of(context)
                          .colorScheme
                          .primary; // Color when selected
                    }
                    return Colors.grey; // Color when not selected
                  }),
                  groupValue: _selectedGender,
                  onChanged: (value) {
                    setState(() {
                      _selectedGender = value!;
                    });
                  },
                ),
                Text(
                  'Female',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          InputTextField(
            controller: widget.usernameController,
            hinttext: "Username",
            obscuretext: false,
            validator: ValidationBuilder().maxLength(10).build(),
          ),
          InputTextField(
            controller: widget.emailController,
            hinttext: "Email",
            obscuretext: false,
            validator: ValidationBuilder().email().maxLength(50).build(),
          ),
          InputTextField(
            controller: widget.passwordController,
            hinttext: "Password",
            obscuretext: true,
            validator: ValidationBuilder().maxLength(15).minLength(8).build(),
          ),
          InputTextField(
            controller: widget.confirmPasswordController,
            hinttext: "Confirm Password",
            obscuretext: true,
            validator: ValidationBuilder().maxLength(15).minLength(8).build(),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: 60,
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.primary),
            child: MaterialButton(
              onPressed: () {
                if (widget.passwordController.text ==
                    widget.confirmPasswordController.text) {
                  if (_selectedGender == "male") {
                    authAPi.signUpAuth(
                        widget.firstNameController.text,
                        widget.lastNameController.text,
                        widget.usernameController.text,
                        widget.passwordController.text,
                        widget.emailController.text,
                        "M",
                        context);
                  } else {
                    authAPi.signUpAuth(
                        widget.firstNameController.text,
                        widget.lastNameController.text,
                        widget.usernameController.text,
                        widget.passwordController.text,
                        widget.emailController.text,
                        "F",
                        context);
                  }
                }
              },
              child: Text(
                "SignUp",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
