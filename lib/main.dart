import 'package:flutter/material.dart';
import 'package:ink_sphere/core/provider/user_auth_data_provider.dart';
import 'package:ink_sphere/core/theme/dark_theme.dart';
import 'package:ink_sphere/core/theme/light_theme.dart';
import 'package:ink_sphere/pages/HomePage/home_page.dart';
import 'package:ink_sphere/pages/OtpPage/otp_page.dart';
import 'package:ink_sphere/pages/SplashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserAuthDataProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const SplashScreen(),
        // home:OtpPage(),
        // home: const HomePage(),
      ),
    );
  }
}
