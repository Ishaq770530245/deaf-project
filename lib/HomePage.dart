import 'package:deafproject/Fahras.dart';
import 'package:deafproject/Text.dart';
import 'package:deafproject/audio.dart';
import 'package:deafproject/detect_sign_language.dart';
import 'package:deafproject/faq.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedLanguage = "en";
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetectSignLanguagePage()),
            );
          }
          if (index == 1) {
            // Get.to(()=>Learn());
            // Get.to(()=>HomePage());
            Get.to(() => FAQPage());
          }
          if (index == 0) {
            //Get.to(() => Settings());
            Get.back();
          }
        },
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.green),
        selectedIconTheme: IconThemeData(
          color: Colors.green,
        ),
        backgroundColor: Color(0xFF002244),
        items:  [
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: "Back".tr),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "Save".tr),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new), label: "Detect sign".tr),
        ],
        showUnselectedLabels: true,
      ),
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
                    child: Text('index'.tr),
                    onTap: () => Get.to(()=>IndexPage()),
                  ),
                ],
              );
            },
            icon: Icon(Icons.open_in_browser),
          ),
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
                print(value);
                print("****************************");
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildNavCard(
              context,
              'Text_Input'.tr,
              Icons.text_fields,
              'Convert text to sign language'.tr,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TextInputScreen()),
              ),
            ),
            const SizedBox(height: 16),
            _buildNavCard(
              context,
              'Audio Recording'.tr,
              Icons.mic,
              'Convert speech to sign language'.tr,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AudioInputScreen()),
              ),
            ),
            const SizedBox(height: 16),
           /* _buildNavCard(
              context,
              'Video Recording'.tr,
              Icons.videocam,
              'Record and analyze sign language'.tr,
              () {},
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildNavCard(BuildContext context, String title, IconData icon,
      String description, VoidCallback onTap) {
    return Card(
      color: const Color(0xFF002244),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: Colors.black),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
