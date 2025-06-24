import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/pages/auth_page/register_page.dart';
import 'package:tixme/pages/main_menu/dashboard_page.dart';
import 'package:tixme/widgets/button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isPasswordVisible = false;
  final WidgetsCustom _widgetsCustom = WidgetsCustom();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              SizedBox(height: 54.0),
              // Image.asset('assets/images/logo.png', height: 270, width: 270),
              Text(
                'Welcome Tixers!',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Let\'s sign in for booking your tickets',
                style: TextStyle(color: AppColor.textColor, fontSize: 12.0),
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(color: AppColor.textColor),
                      ),
                      SizedBox(height: 8.0),
                      _buildTextField('Email', emailController, false),
                      SizedBox(height: 16.0),
                      Text(
                        'Password',
                        style: TextStyle(color: AppColor.textColor),
                      ),
                      SizedBox(height: 8.0),
                      _buildTextField(
                        'Password',
                        passwordController,
                        _isPasswordVisible,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              _widgetsCustom.customButton('Login', () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              }),
              SizedBox(height: 16.0),
              Text(
                'Don\'t have an account?',
                style: TextStyle(color: AppColor.textColor),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(color: AppColor.secondaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField(
  String hint,
  TextEditingController controller,
  bool isPasswordVisible,
) {
  return TextField(
    controller: controller,
    obscureText: isPasswordVisible,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: hint,
      fillColor: Colors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.accentColor),
      ),
    ),
  );
}
