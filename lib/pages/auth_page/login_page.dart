import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/pages/auth_page/register_page.dart';
import 'package:tixme/pages/main_menu/dashboard_page.dart';
import 'package:tixme/services/auth_service/login_service.dart';
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
  bool _isPasswordVisible = false;
  final WidgetsCustom _widgetsCustom = WidgetsCustom();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      print('Login: Starting login process...');
      final result = await LoginService.login(
        emailController.text,
        passwordController.text,
      );

      print('Login: Login result: $result');

      setState(() {
        _isLoading = false;
      });

      if (result['success']) {
        // Verify token was saved
        final savedToken = await LoginService.getTokenFromPreferences();
        final isLoggedIn = await LoginService.isUserLoggedIn();

        print('Login: Token saved: $savedToken');
        print('Login: Is logged in: $isLoggedIn');

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful!'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to dashboard
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message'] ?? 'Login failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      print('Login: Error during login: $e');

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

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
                      _buildTextField('Email', emailController, false, true),
                      SizedBox(height: 16.0),
                      Text(
                        'Password',
                        style: TextStyle(color: AppColor.textColor),
                      ),
                      SizedBox(height: 16.0),
                      _buildTextField(
                        'Password',
                        passwordController,
                        _isPasswordVisible,
                        false,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              _widgetsCustom.customButton('Login', _handleLogin),
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
  bool isEmail,
) {
  return TextFormField(
    controller: controller,
    obscureText: hint.contains('Password') ? !isPasswordVisible : false,
    keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return '*${hint} is required';
      }
      if (isEmail && (!value.contains('@') || !value.contains('.'))) {
        return 'Email must contain @ and .';
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: hint,
      fillColor: Colors.white,
      filled: true,
      suffixIcon:
          hint.contains('Password')
              ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColor.accentColor,
                ),
                onPressed: () {
                  // This would need to be handled in the state class
                  // For now, we'll keep it simple
                },
              )
              : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColor.accentColor),
      ),
    ),
  );
}
