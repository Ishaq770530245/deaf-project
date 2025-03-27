import 'package:deafproject/FirstPage.dart';
import 'package:deafproject/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  // Dropdown values
  String selectedGender = 'Male';
  String selectedDisability = 'Deaf';
  String _selectedLanguage = "en";

  // Default notification time (or could be set dynamically)
  String defaultNotificationTime = "08:00 AM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register".tr, style: const TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.change_circle),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  250.0,
                  100.0,
                  _selectedLanguage == 'en' ? 0.0 : 250.0,
                  0.0,
                ),
                items: const [
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
                AutovalidateMode.disabled, // errors show only on submit
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo and header
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/logo.jpeg"),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Create Account".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Sign up to get started".tr,
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
                          label: "Name".tr,
                          controller: _nameController,
                          prefixIcon: Icons.person_outline,
                          hintText: "Enter your name".tr,
                          validator: (value) =>
                              value!.isEmpty ? "Name is required" : null,
                        ),
                        const SizedBox(height: 24),
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
                        const SizedBox(height: 24),
                        _buildFormField(
                          label: "Confirm Password".tr,
                          controller: _confirmPasswordController,
                          prefixIcon: Icons.lock_outline,
                          hintText: "Re-enter your password".tr,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return "Confirm your password";
                            if (value != _passwordController.text)
                              return "Passwords do not match";
                            return null;
                          },
                        ),
                        Row(
                          children: [],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Gender".tr,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Center(
                          child: DropdownButton<String>(
                            dropdownColor: const Color(0xFF002244),
                            value: selectedGender,
                            items: [
                              DropdownMenuItem(
                                  value: "Male", child: Text("Male".tr)),
                              DropdownMenuItem(
                                  value: "Female", child: Text("Female".tr)),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Are you disabled".tr,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Center(
                          child: DropdownButton<String>(
                            dropdownColor: const Color(0xFF002244),
                            value: selectedDisability,
                            items: [
                              DropdownMenuItem(
                                  value: "Deaf", child: Text("Deaf".tr)),
                              DropdownMenuItem(
                                  value: "Mute", child: Text("Mute".tr)),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedDisability = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: SizedBox(
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
                              "Sign Up".tr,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Back To Login".tr,
                        style: const TextStyle(color: Colors.blue),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build text form fields
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

  Future<void> _handleSignUp() async {
    // Only validate when the user submits
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Create user map to insert in SQLite database
      Map<String, dynamic> user = {
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text, // Consider hashing this!
        'gender': selectedGender,
        'disability': selectedDisability,
        'language': _selectedLanguage,
        'notificationTime': defaultNotificationTime,
      };

      try {
        await DBHelper().insertUser(user);
        Get.snackbar(
          "Success".tr,
          "Registration successful".tr,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
          borderRadius: 6,
          icon: const Icon(Icons.check_circle, color: Colors.green),
        );

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Firstpage()));
      } catch (e) {
        Get.snackbar("Error".tr, e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.red,
            borderRadius: 6,
            icon: const Icon(Icons.error_rounded, color: Colors.red));
      } finally {
        setState(() => _isLoading = false);
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
