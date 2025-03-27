// main.dart
import 'package:deafproject/FirstPage.dart';
import 'package:deafproject/ForgetPassword.dart';
import 'package:deafproject/Signup.dart';
import 'package:deafproject/auth/login.dart';
import 'package:deafproject/controller/SignLanguageController.dart';
import 'package:deafproject/translations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DeafAssistApp());
}

class DeafAssistApp extends StatelessWidget {
  DeafAssistApp({Key? key}) : super(key: key);
  SignLanguageController c = Get.put(SignLanguageController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // print("jgkdgjkfkjgfdjkfgdjklfdk");
      return GetMaterialApp(
        locale: Locale("en"),
        translations: AppTranslations(),
        debugShowCheckedModeBanner: false,
        title: 'Deaf Assist',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: const Color(0xFF002244),
          cardColor: const Color(0xFF002244),
          appBarTheme: const AppBarTheme(
            backgroundColor: const Color(0xFF002244),
            elevation: 0,
          ),
          textTheme: TextTheme(
            bodyMedium: c.selectedFont.value,
            bodyLarge: c.selectedFont.value,
            bodySmall: c.selectedFont.value,
            displayLarge: c.selectedFont.value,
            displayMedium: c.selectedFont.value,
            displaySmall: c.selectedFont.value,
            headlineLarge: c.selectedFont.value,
            headlineMedium: c.selectedFont.value,
            headlineSmall: c.selectedFont.value,
            labelLarge: c.selectedFont.value,
            labelMedium: c.selectedFont.value,
            labelSmall: c.selectedFont.value,
            titleLarge: c.selectedFont.value,
            titleMedium: c.selectedFont.value,
            titleSmall: c.selectedFont.value,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[900],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.purple, width: 2),
            ),
          ),
        ),
        // home: const LoginScreen(),
        home: const Login(),
      );
    });
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

// login_screen.dart
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String _selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deaf_App".tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  250.0, // Show left for English
                  100.0, // Vertical position remains the same
                  _selectedLanguage == 'en'
                      ? 0.0
                      : 250.0, // Show right for Arabic
                  0.0, // Horizontal offset remains the same
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
                    Get.updateLocale(Locale(value)); // Update the locale
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
                          'welcome_back'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'sign_in_to_continue'.tr,
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Email Field
                          _buildFormField(
                            label: 'email'.tr,
                            controller: _emailController,
                            prefixIcon: Icons.email_outlined,
                            hintText: 'enter_email'.tr,
                            keyboardType: TextInputType.emailAddress,
                            validator: FormValidator.validateEmail,
                          ),
                          const SizedBox(height: 24),

                          // Password Field
                          _buildFormField(
                            label: 'password'.tr,
                            controller: _passwordController,
                            prefixIcon: Icons.lock_outline,
                            hintText: 'enter_password'.tr,
                            isPassword: true,
                            validator: FormValidator.validatePassword,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(() => Forgetpassword());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : Text(
                                      'Forget_Password'.tr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'sign_in'.tr,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
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
                  Center(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.google,
                                size: 25,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                                size: 25,
                                color: Colors.blue,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.twitter,
                                size: 25,
                                color: Colors.lightBlue,
                              ))
                        ],
                      ),
                      width: 200,
                    ),
                  )
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
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white, // Label text color set to white
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Colors.black, // Background color set to black
            filled: true, // Ensures the fill color is applied
            hintText: hintText,
            hintStyle:
                const TextStyle(color: Colors.white70), // Hint text color
            prefixIcon: Icon(
              prefixIcon,
              color: Colors.white, // Prefix icon color
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.white, // Suffix icon color
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners
              borderSide: const BorderSide(color: Colors.white), // Border color
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.white), // Border color
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: Colors.white,
                  width: 2), // Focused border color and thickness
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Colors.red), // Error border color
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: Colors.red, width: 2), // Error border when focused
            ),
            errorMaxLines: 3,
          ),
          keyboardType: keyboardType,
          obscureText: isPassword && _obscurePassword,
          style: const TextStyle(color: Colors.white), // Input text color
          validator: validator,
          onChanged: (value) {
            if (isPassword) {
              setState(() {});
            }
          },
        ),
      ],
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Firstpage()),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
