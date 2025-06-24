import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/pages/auth_page/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
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
