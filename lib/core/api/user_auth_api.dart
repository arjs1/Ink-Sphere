import 'dart:convert';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ink_sphere/core/provider/user_auth_data_provider.dart';
import 'package:ink_sphere/pages/HomePage/home_page.dart';
import 'package:ink_sphere/pages/LoginPage/login_page.dart';
import 'package:ink_sphere/pages/OtpPage/otp_page.dart';
import 'package:provider/provider.dart';

class UserAuthApi {
  Future<void> signUpAuth(
      String firstName,
      String lastName,
      String username,
      String password,
      String email,
      String gender,
      BuildContext context) async {
    const apiUrl =
        "https://blogapp-production-53f2.up.railway.app/users/create/";
    final uri = Uri.parse(apiUrl);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "username": username,
          "email": email,
          "first_name": firstName,
          "last_name": lastName,
          "password": password,
          "gender": gender,
        },
      ),

      // M- Male F-Female
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);

      final token = responseBody['token'];
      // Map<String, dynamic> responseData = jsonDecode(response.body);
      debugPrint(token);
      // debugPrint("ID: ${responseData['id']}");

      // ignore: use_build_context_synchronously
      Provider.of<UserAuthDataProvider>(context, listen: false)
          .userAuthToken(token);
      Provider.of<UserAuthDataProvider>(context, listen: false)
          .setToken(token, username, email, firstName, lastName, gender);
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => OtpPage(),
        ),
      );

      // Add more fields as necessary
    } else {
      debugPrint("Unsuccessful: ${response.body}");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Headers: ${response.headers}");
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Credential"),
            content: Text("Please Enter valid Data"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // otp verification
  Future<void> otpVerification(String otpData, BuildContext context) async {
    final otpUrl =
        "https://blogapp-production-53f2.up.railway.app/users/verify/";
    final url = Uri.parse(otpUrl);
    final token =
        Provider.of<UserAuthDataProvider>(context, listen: false).authToken;
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Token $token',
        },
        body: jsonEncode({
          "otp": otpData,
        }),
      );

      if (response.statusCode == 200) {
        debugPrint('Response data: ${response.body}');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false);
      } else {
        // Handle other status codes
        debugPrint(token);
        debugPrint(response.body);
        debugPrint('Request failed with status: ${response.statusCode}');
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Invalid OTP",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle any errors
      debugPrint('An error occurred: $e');
    }
    return;
  }

  Future<void> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    final loginUrl =
        "https://blogapp-production-53f2.up.railway.app/users/login/";
    final uri = Uri.parse(loginUrl);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        // "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final token = responseBody['token'];

      final user = responseBody['user'];
      // final id = user['id'];
      final userName = user['username'];
      final userEmail = user['email'];
      final firstName = user['first_name'];
      final lastName = user['last_name'];
      final gender = user['gender'];
      // final profile = user['profile'];
      // final gender = profile['profileGender'];
      // final profileId = profile['profileID'];
      // final age = profile['profileAge'];
      debugPrint(response.body);

      // Access the LoginProvider and set the token
      Provider.of<UserAuthDataProvider>(context, listen: false)
          .setToken(token, userName, userEmail, firstName, lastName, gender);
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      // Add more fields as necessary
    } else {
      debugPrint("Unsuccessful: ${response.body}");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Headers: ${response.headers}");
    }
  }

  // this function is to send otp when email is entered in forget password
  Future<void> forgetPasswordOtpSend(String userEmail) async {
    const forgetApiUrl =
        "https://blogapp-production-53f2.up.railway.app/user/forget-password/send-otp/";
    final uri = Uri.parse(forgetApiUrl);
    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": userEmail,
        // "username": username,
        // "password": password,
      }),
    );

    if (response.statusCode == 200) {
      // final responseBody = jsonDecode(response.body);

      // final token = responseBody['token'];

      // final user = responseBody['user'];
      // final id = user['id'];
      // final userName = user['username'];
      // final userEmail = user['email'];
      // final firstName = user['first_name'];
      // final lastName = user['last_name'];
      // final gender = user['gender'];
      // final profile = user['profile'];
      // final gender = profile['profileGender'];
      // final profileId = profile['profileID'];
      // final age = profile['profileAge'];
      debugPrint(response.body);

      // Access the LoginProvider and set the token
      // Provider.of<UserAuthDataProvider>(context, listen: false)
      //     .setToken(token, userName, userEmail, firstName, lastName, gender);
      // Navigator.push(
      //   // ignore: use_build_context_synchronously
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomePage(),
      //   ),
      // );
      // Add more fields as necessary
    } else {
      debugPrint("Unsuccessful: ${response.body}");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Headers: ${response.headers}");
    }
  }

  // forget password otp verification api call
  Future<void> forgetPasswordOtpVerify(
      String otpData, String userEmail, BuildContext context) async {
    final otpUrl =
        "https://blogapp-production-53f2.up.railway.app/user/forget-password/verify-otp/";
    final url = Uri.parse(otpUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "otp": otpData,
          "email": userEmail,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final token = responseBody['token'];
        // Map<String, dynamic> responseData = jsonDecode(response.body);
        debugPrint(token);
        // debugPrint("ID: ${responseData['id']}");

        // ignore: use_build_context_synchronously
        Provider.of<UserAuthDataProvider>(context, listen: false)
            .userAuthToken(token);
        debugPrint('Response data: ${response.body}');
        Provider.of<UserAuthDataProvider>(context, listen: false).isverified =
            true;
      } else {
        // Handle other status codes

        debugPrint(response.body);
        debugPrint('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      debugPrint('An error occurred: $e');
    }
    return;
  }

  // password changed after verification

  Future<void> forgetPasswordChange(
      String changePassword, BuildContext context) async {
    final otpUrl =
        "https://blogapp-production-53f2.up.railway.app/user/forget-password/";
    final url = Uri.parse(otpUrl);
    final token =
        Provider.of<UserAuthDataProvider>(context, listen: false).authToken;
    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Token $token',
        },
        body: jsonEncode({"password": changePassword}),
      );

      if (response.statusCode == 200) {
        // final responseBody = jsonDecode(response.body);

        debugPrint('Response data: ${response.body}');
        // Provider.of<UserAuthDataProvider>(context, listen: false).isverified =
        //     true;
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: AlertDialog(
                title: Text(
                  "Password Changed",
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Theme.of(context).colorScheme.primary,
                    child: TextButton(
                      child: Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      } else {
        // Handle other status codes

        debugPrint(response.body);
        debugPrint('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors
      debugPrint('An error occurred: $e');
    }
    return;
  }
}
