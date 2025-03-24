// signup_screen.dart
import 'package:deafproject/FirstPage.dart';
import 'package:deafproject/HomePage.dart';
import 'package:deafproject/Info.dart';
import 'package:deafproject/controller/SignLanguageController.dart';
import 'package:deafproject/learn.dart';
import 'package:deafproject/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  SignLanguageController controller = Get.find<SignLanguageController>();
  String selectedValue = 'Male';
  String selectedValue2 = 'Deaf';
  String _selectedLanguage = "en";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Everyone Welcome".tr,
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  250.0,
                  100.0,
                  _selectedLanguage == 'en' ? 0.0 : 250.0,
                  0.0,
                ),
                items: [
                  PopupMenuItem<String>(
                    value: 'en',
                    child: Text('English'),
                  ),
                  PopupMenuItem<String>(
                    value: 'ar',
                    child: Text('Arabic'),
                  ),
                ],
              ).then((value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value == 'en' ? 'English' : 'Arabic';
                    Get.updateLocale(Locale(value));
                  });
                }
              });
            },
            icon: Icon(Icons.change_circle),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo and Welcome Text
                  Center(
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: MediaQuery.of(context).size.height * 15 / 100,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/logo.jpeg"),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Create Account'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign up to get started'.tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Form Fields Card
                  Card(
                    color: const Color(0xFF002244),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name Field
                          _buildFormField(
                            label: 'Name'.tr,
                            controller: _nameController,
                            prefixIcon: Icons.person_outline,
                            hintText: 'Enter your name'.tr,
                            validator: (value) =>
                                value!.isEmpty ? 'Name is required' : null,
                          ),
                          const SizedBox(height: 24),

                          // Email Field
                          _buildFormField(
                            label: 'Email'.tr,
                            controller: _emailController,
                            prefixIcon: Icons.email_outlined,
                            hintText: 'Enter your email'.tr,
                            keyboardType: TextInputType.emailAddress,
                            validator: FormValidator.validateEmail,
                          ),
                          const SizedBox(height: 24),

                          // Password Field
                          _buildFormField(
                            label: 'Password'.tr,
                            controller: _passwordController,
                            prefixIcon: Icons.lock_outline,
                            hintText: 'Enter your password'.tr,
                            isPassword: true,
                            validator: FormValidator.validatePassword,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Gender".tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 80,
                            //   color: Colors.red,
                            child: FittedBox(
                              child: DropdownButton<String>(
                                dropdownColor: Color(0xFF002244),
                                value: selectedValue,
                                items: [
                                  DropdownMenuItem(
                                      value: "Male", child: Text("Male".tr)),
                                  DropdownMenuItem(
                                      value: "Female",
                                      child: Text("Female".tr)),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                              ),
                            ),
                            width: Get.width * 9 / 10,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Are you disabled".tr,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            height: 80,
                            //   color: Colors.red,
                            child: FittedBox(

                              child: DropdownButton<String>(
                                dropdownColor: Color(0xFF002244),
                                value: selectedValue2 ??
                                    "Deaf", // Provide a default value if null
                                items: [
                                  DropdownMenuItem(
                                      value: "Deaf", child: Text("Deaf".tr)),
                                  DropdownMenuItem(
                                      value: "Mute", child: Text("Mute".tr)),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedValue2 =
                                          value; // Ensure correct variable is updated
                                    });
                                  }
                                },
                              ),
                            ),
                            width: Get.width * 9 / 10,
                          ),

                          // Confirm Password Field
                        ],
                      ),
                    ),
                  ),

                  // Sign Up Button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignUp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'sign_up'.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  Center(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.google,
                                  size: 25, color: Colors.red)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.facebook,
                                  size: 25, color: Colors.blue)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(FontAwesomeIcons.twitter,
                                  size: 25, color: Colors.lightBlue))
                        ],
                      ),
                      width: 200,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "Back To Login".tr,
                            style: TextStyle(color: Colors.blue),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData prefixIcon,
    required String hintText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.black,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white70),
            prefixIcon: Icon(prefixIcon, color: Colors.white),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
          keyboardType: keyboardType,
          obscureText: isPassword && _obscurePassword,
          style: const TextStyle(color: Colors.white),
          validator: validator,
        ),
      ],
    );
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Firstpage()),
        ); // Redirect to previous screen or login screen
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

class FormValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Regular expression for email validation
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    return null;
  }
}
