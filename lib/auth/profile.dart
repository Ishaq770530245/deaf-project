import 'package:deafproject/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_profile.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map<String, dynamic>? user;

  // Define icons for each field
  final Map<String, IconData> fieldIcons = {
    "Name": Icons.person,
    "Email": Icons.email,
    "Gender": Icons.transgender,
    "Disability": Icons.disabled_visible,
    "Language": Icons.language,
    "Notification Time": Icons.alarm,
  };

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    // For demonstration, load the first user.
    final users = await DBHelper().getUsers();
    if (users.isNotEmpty) {
      setState(() {
        user = users.first;
      });
    }
  }

  Future<void> _handleLogout() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  Future<void> _handleDeleteAccount() async {
    if (user == null) return;
    bool confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Delete Account".tr),
            content: Text("Are you sure you want to delete your account?".tr),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel".tr),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Delete".tr,
                    style: const TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ) ??
        false;
    if (confirmed) {
      await DBHelper().deleteUser(user!['id']);
      Get.snackbar("Error".tr, "Your account has been deleted".tr,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          borderRadius: 6,
          icon: const Icon(Icons.error_rounded, color: Colors.red));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    }
  }

  Widget _buildInfoRow(String field, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(fieldIcons[field] ?? Icons.info, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text("$field: ",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile".tr, style: const TextStyle(fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfile()),
              ).then((_) => _loadUser());
            },
          ),
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    // Profile Card with modern design
                    Card(
                      color: const Color(0xFF002244),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            // Profile picture
                            Center(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: user!['image'] != null
                                    ? NetworkImage(user!['image'])
                                    : null,
                                child: user!['image'] == null
                                    ? Text(
                                        user!['name']
                                            .toString()
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 40, color: Colors.white),
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildInfoRow("Name", user!['name']),
                            _buildInfoRow("Email", user!['email']),
                            _buildInfoRow("Gender", user!['gender'] ?? ""),
                            _buildInfoRow(
                                "Disability", user!['disability'] ?? ""),
                            _buildInfoRow("Language", user!['language'] ?? ""),
                            _buildInfoRow("Notification Time",
                                user!['notificationTime'] ?? ""),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Full-width buttons
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: _handleLogout,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Logout".tr,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _handleDeleteAccount,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text("Delete Account".tr,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
