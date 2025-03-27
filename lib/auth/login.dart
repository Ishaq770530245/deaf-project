import 'package:deafproject/auth/forgetpassword.dart';
import 'package:deafproject/auth/register.dart';
import 'package:deafproject/db_helper.dart'; // Import your DBHelper
import 'package:deafproject/learn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String _selectedLanguage = "en";

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Query SQLite database for the user with matching email
      final user =
          await DBHelper().getUserByEmail(_emailController.text.trim());

      setState(() => _isLoading = false);

      if (user == null) {
        Get.snackbar("Error".tr, "User not found".tr,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            borderRadius: 6,
            icon: const Icon(Icons.error_rounded, color: Colors.red));
      } else {
        // Compare passwords (in production, use hashing)
        if (user['password'] == _passwordController.text.trim()) {
          Get.snackbar(
            "Success".tr,
            "Login successful".tr,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.green,
            borderRadius: 6,
            icon: const Icon(Icons.check_circle, color: Colors.green),
          );

          // Navigate to Profile page after successful login
          // (Replace with your home page if needed)
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Learn()));
        } else {
          Get.snackbar("Error".tr, "Invalid credentials".tr,
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.red,
              borderRadius: 6,
              icon: const Icon(Icons.error_rounded, color: Colors.red));
        }
      }
    }
  }

  Future<void> showAppExitConfirmationDialog(BuildContext context) async {
    bool? exitConfirmed = await showGeneralDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Exit App",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          ),
          child: FadeTransition(
            opacity: animation,
            child: AlertDialog(
              backgroundColor: const Color(0xFF002244),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  const Icon(Icons.sentiment_dissatisfied, color: Colors.white),
                  const SizedBox(width: 8),
                  Text("Exit App".tr,
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              content: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.sentiment_dissatisfied,
                      color: Colors.white70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Are you sure you want to exit the application?".tr,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("Cancel".tr,
                      style: const TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.sentiment_dissatisfied,
                          color: Colors.redAccent),
                      const SizedBox(width: 4),
                      Text("Exit".tr,
                          style: const TextStyle(color: Colors.redAccent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (exitConfirmed == true) {
      // Exit the entire application
      SystemNavigator.pop();
    }
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
        Text(label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await showAppExitConfirmationDialog(context);
          },
        ),
        title: Text("Login".tr, style: const TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.change_circle),
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(250.0, 100.0, 0.0, 0.0),
                items: const [
                  PopupMenuItem<String>(value: 'en', child: Text('English')),
                  PopupMenuItem<String>(value: 'ar', child: Text('Arabic')),
                ],
              ).then((value) {
                if (value != null) {
                  setState(() {
                    _selectedLanguage = value;
                    Get.updateLocale(Locale(value));
                  });
                }
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            autovalidateMode:
                AutovalidateMode.disabled, // errors shown on submit
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo and Header
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/logo.jpeg"),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Welcome Back".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Log in to continue".tr,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Card(
                  color: const Color(0xFF002244),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildFormField(
                          label: "Email".tr,
                          controller: _emailController,
                          prefixIcon: Icons.email_outlined,
                          hintText: "Enter your email".tr,
                          keyboardType: TextInputType.emailAddress,
                          validator: FormValidator.validateEmail,
                        ),
                        const SizedBox(height: 24),
                        _buildFormField(
                          label: "Password".tr,
                          controller: _passwordController,
                          prefixIcon: Icons.lock_outline,
                          hintText: "Enter your password".tr,
                          isPassword: true,
                          validator: FormValidator.validatePassword,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Login".tr,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgetPassword()));
                    },
                    child: Text("Forgot Password?".tr,
                        style: const TextStyle(color: Colors.blue)),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: Text("Don't have an account? Register".tr,
                        style: const TextStyle(color: Colors.blue)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class FormValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) return "Enter a valid email";
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password is required";
    return null;
  }
}
