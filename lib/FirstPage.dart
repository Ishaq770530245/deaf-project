import 'package:deafproject/Help.dart';
import 'package:deafproject/NotificationPage.dart';
import 'package:deafproject/Settings.dart';
import 'package:deafproject/Survey.dart';
import 'package:deafproject/aboutus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  int index = 0;
  String _selectedLanguage = "en";
  String color = "green";
  Color selectedcolor = Color(0xFF002244);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index = value;
          });
          if (index == 1) {
            Get.to(() => Settings());
          }
          if(index == 0)
          {
            Get.to(() => HelpPage());
          }
          if(index==2)
          {
             Get.to(() => AboutUsPage());
          }
        },
        showSelectedLabels: true,
        backgroundColor: Color(0xFF002244),
        selectedLabelStyle: TextStyle(color: color == "green"
                    ? Colors.green
                    : color == "red"
                        ? Colors.red
                        : color == "orange"
                            ? Colors.orange
                            : Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        items: [
          BottomNavigationBarItem(

              icon: Icon(
                Icons.help,
                color: color == "green"
                    ? Colors.green
                    : color == "red"
                        ? Colors.red
                        : color == "orange"
                            ? Colors.orange
                            : Colors.white,
              ),
              label: "Help".tr),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: color == "green"
                    ? Colors.green
                    : color == "red"
                        ? Colors.red
                        : color == "orange"
                            ? Colors.orange
                            : Colors.white,
              ),
              label: "Settings".tr),
          BottomNavigationBarItem(

              icon: Icon(Icons.import_contacts,
                  color: color == "green"
                      ? Colors.green
                      : color == "red"
                          ? Colors.red
                          : color == "orange"
                              ? Colors.orange
                              : Colors.white),
              label: "About".tr),
        ],
        showUnselectedLabels: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                child: Text(
                  "Deaf and Mute program".tr,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Container(
                child: Text(
                  "Welcome You!".tr,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Container(
              child: Image.asset("assets/photo3.jpeg"),
            ),
            Text(
              "Trasform All Your Signs to Words through our app.".tr,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Image.asset("assets/photo2.jpeg"),
            ),
            Text(
              "Use the search to find what you need.".tr,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            /*   Container(
              width: Get.width * 9 / 10,
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  filled: true,
                  hintStyle: const TextStyle(color: Colors.white70),
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
                style: const TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 15,
            ),*/
            Container(
              child: ElevatedButton(
                  onPressed: () {
                    // Get.to(()=>Forgetpassword());
                    Get.to(() => Survey());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Start'.tr,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              width: Get.width * 6 / 10,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: selectedcolor,
        title: Text(
          "Everyone Welcome".tr,
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          DropdownButton<String>(
            value: color,
            hint: Text(
              "Select an option",
              style: TextStyle(color: Colors.black),
            ),
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            dropdownColor: Colors.black,
            style: TextStyle(color: Colors.white),
            underline: SizedBox(), // Remove default underline
            onChanged: (String? newValue) {
              setState(() {
                color = newValue!;
              });
              if (color == "green") {
                setState(() {
                  selectedcolor = Colors.green;
                });
              }
              if (color == "red") {
                setState(() {
                  selectedcolor = Colors.red;
                });
              }
              if (color == "orange") {
                setState(() {
                  selectedcolor = Colors.orange;
                });
              }
              if (color == "default") {
                setState(() {
                  selectedcolor = Color(0xFF002244);
                });
              }
            },
            items: <String>['green', 'red', 'orange', 'default']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value.tr),
              );
            }).toList(),
          ),
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
          IconButton(
              onPressed: () {
                Get.to(() => NotificationPage());
              },
              icon: Icon(Icons.notifications)),
        ],
      ),
    );
  }
}
