import 'package:flutter/material.dart';

class UserAuthDataProvider extends ChangeNotifier {
  // String? userId;
  String? userName;
  String? userEmail;
  String? authToken;
  String? firstName;
  String? lastName;
  String? gender;
  bool isverified = false;
  void setToken(
    token,
    // id,
    username,
    email,
    firstname,
    lastname,
    genderData,
  ) {
    // userId = id;
    authToken = token;
    userName = username;
    userEmail = email;
    firstName = firstname;
    lastName = lastname;
    gender = genderData;

    debugPrint(
        " $authToken  _ $userName _ $userEmail _ $firstName _ $lastName _$genderData ");
    notifyListeners();
  }

  void userAuthToken(String userToken) {
    authToken = userToken;
    notifyListeners();
  }

  void verification() {
    isverified = true;
    notifyListeners();
  }
}
