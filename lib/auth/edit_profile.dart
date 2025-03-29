import 'package:deafproject/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  // You can add more controllers if needed, e.g. for updating password

  String selectedGender = 'Male';
  String selectedDisability = 'Deaf';
  String _selectedLanguage = "en";
  String defaultNotificationTime = "08:00 AM";

  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    // For demonstration, we load the first user.
    final users = await DBHelper().getUsers();
    if (users.isNotEmpty) {
      user = users.first;
      _nameController.text = user!['name'];
      _emailController.text = user!['email'];
      selectedGender = user!['gender'] ?? 'Male';
      selectedDisability = user!['disability'] ?? 'Deaf';
      _selectedLanguage = user!['language'] ?? 'en';
      defaultNotificationTime = user!['notificationTime'] ?? '08:00 AM';
      setState(() {});
    }
  }

  Future<void> _handleUpdate() async {
    defaultNotificationTime = user!['notificationTime'] ?? '08:00 AM';

    if (_formKey.currentState!.validate() && user != null) {
      Map<String, dynamic> updatedUser = {
        'name': _nameController.text,
        'email': _emailController.text,
        'gender': selectedGender,
        'disability': selectedDisability,
        'language': _selectedLanguage,
        'notificationTime': defaultNotificationTime,
      };
      await DBHelper().updateUser(user!['id'], updatedUser);
      Get.snackbar(
        "Success".tr,
        "Profile updated successfully".tr,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.green,
        borderRadius: 6,
        icon: const Icon(Icons.check_circle, color: Colors.green),
      );

      Navigator.pop(context);
    }
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData prefixIcon,
    required String hintText,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
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
        title: Text("Edit Profile".tr, style: const TextStyle(fontSize: 20)),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Center(
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage("assets/logo.jpeg"),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "Edit Profile".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
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
                              Text(
                                "Gender".tr,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              DropdownButton<String>(
                                dropdownColor: const Color(0xFF002244),
                                value: selectedGender,
                                items: [
                                  DropdownMenuItem(
                                      value: "Male", child: Text("Male".tr)),
                                  DropdownMenuItem(
                                      value: "Female",
                                      child: Text("Female".tr)),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "Are you disabled".tr,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              DropdownButton<String>(
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: _handleUpdate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Update Profile",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
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
    _nameController.dispose();
    _emailController.dispose();
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
}
