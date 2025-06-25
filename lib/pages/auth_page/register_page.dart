import 'package:flutter/material.dart';
import 'package:tixme/const/app_color.dart';
import 'package:tixme/models/register_response.dart';
import 'package:tixme/pages/auth_page/login_page.dart';
import 'package:tixme/services/auth_service/register_service.dart';
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
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final WidgetsCustom _widgetsCustom = WidgetsCustom();
  RegisterResponse? _registerResponse;
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password confirmation does not match'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await RegisterService.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      setState(() {
        _registerResponse = response;
        _isLoading = false;
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate to login page or dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.toString()}'),
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
          child: SingleChildScrollView(
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
                        Text(
                          'Name',
                          style: TextStyle(color: AppColor.textColor),
                        ),
                        SizedBox(height: 8.0),
                        _buildTextField('Name', nameController, false, false, (
                          value,
                        ) {
                          if (value == null || value.isEmpty) {
                            return '*Name is required';
                          }
                          return null;
                        }),
                        SizedBox(height: 16.0),
                        Text(
                          'Email',
                          style: TextStyle(color: AppColor.textColor),
                        ),
                        SizedBox(height: 8.0),
                        _buildTextField('Email', emailController, false, true, (
                          value,
                        ) {
                          if (value == null || value.isEmpty) {
                            return '*Email is required';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Email must contain @ and .';
                          }
                          return null;
                        }),
                        SizedBox(height: 16.0),
                        Text(
                          'Password',
                          style: TextStyle(color: AppColor.textColor),
                        ),
                        SizedBox(height: 8.0),
                        _buildTextField(
                          'Password (Min 8 characters)',
                          passwordController,
                          _isPasswordVisible,
                          false,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return '*Password is required';
                            }
                            if (!RegExp(
                              r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])',
                            ).hasMatch(value)) {
                              return 'Password must contain: \n- 8 characters a\n- uppercase letter (Ex:Password123!) \n- number (Ex: 0-9) \n- symbol (Ex: !@#%&*)';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
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
                          _isConfirmPasswordVisible,
                          false,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return '*Confirm password is required';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                _widgetsCustom.customButton(
                  _isLoading ? 'Registering...' : 'Register',
                  _isLoading ? () {} : _handleRegister,
                ),
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
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    TextEditingController controller,
    bool isPasswordVisible,
    bool isEmail,
    String? Function(String?) validator,
  ) {
    return TextFormField(
      controller: controller,
      obscureText: hint.contains('Password') ? !isPasswordVisible : false,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      validator: validator,
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
                    setState(() {
                      if (hint == 'Password') {
                        _isPasswordVisible = !_isPasswordVisible;
                      } else if (hint == 'Confirm Password') {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      }
                    });
                  },
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColor.accentColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
