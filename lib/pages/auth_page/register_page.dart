import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/widgets/button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
                'Here you are Tixers!',
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Let\'s sign up to book your tickets',
                style: TextStyle(color: AppColor.textColor, fontSize: 12.0),
              ),
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name', style: TextStyle(color: AppColor.textColor)),
                      SizedBox(height: 8.0),
                      _buildTextField('Name', nameController, false),
                      SizedBox(height: 16.0),
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
                      SizedBox(height: 16.0),
                      Text(
                        'Confirm Password',
                        style: TextStyle(color: AppColor.textColor),
                      ),
                      SizedBox(height: 8.0),
                      _buildTextField(
                        'Confirm Password',
                        confirmPasswordController,
                        _isPasswordVisible,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              _widgetsCustom.customButton('Register', () {}),
              SizedBox(height: 16.0),
              Text(
                'Already have an account?',
                style: TextStyle(color: AppColor.textColor),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(color: AppColor.secondaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
