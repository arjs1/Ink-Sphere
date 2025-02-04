import 'package:flutter/material.dart';
import 'package:ink_sphere/core/provider/user_auth_data_provider.dart';
import 'package:ink_sphere/pages/LoginPage/login_page.dart';
import 'package:provider/provider.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});
  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    String userAuthToken =
        Provider.of<UserAuthDataProvider>(context, listen: false)
            .authToken
            .toString();
    final userAuthData =
        Provider.of<UserAuthDataProvider>(context, listen: false);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(userAuthToken),
          Text(userAuthData.firstName.toString()),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("logout"),
            ),
          ),
        ],
      ),
    );
  }
}
