import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/pages/auth_page/login_page.dart';
import 'package:tixme/pages/main_menu/main_page/main_page.dart';
import 'package:tixme/services/auth_service/login_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    // Check if user is already logged in
    final isLoggedIn = await LoginService.isUserLoggedIn();
    final token = await LoginService.getTokenFromPreferences();

    print('Splash: Checking login status...');
    print('Splash: Is logged in: $isLoggedIn');
    print('Splash: Token: $token');

    if (isLoggedIn && token != null) {
      // User is logged in, navigate to dashboard
      print('Splash: User is logged in, navigating to dashboard');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardPage()),
      );
    } else {
      // User is not logged in, navigate to login page
      print('Splash: User is not logged in, navigating to login page');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset('assets/images/logo.png', height: 270, width: 270),
              const SizedBox(height: 20),
              Spacer(),
              CircularProgressIndicator(color: AppColor.textColor),
              Spacer(),
              Text('Loading...', style: TextStyle(color: AppColor.textColor)),
              Spacer(),
              Text('ver 1.0.0', style: TextStyle(color: AppColor.textColor)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
