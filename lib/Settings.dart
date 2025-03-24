import 'package:deafproject/NotificationPage.dart';
import 'package:deafproject/audio.dart';
import 'package:deafproject/controller/SignLanguageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<Color> colors = [
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.teal,
    Colors.amber,
  ];
  SignLanguageController controller = Get.find();
  String selectedValue = "Roboto";
  String _selectedLanguage = "en";
  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                child: Text(
                  "Change_Color".tr + " : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: controller.selectedColor.value),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                child: DropdownButton<String>(
                  
                  value: selectedValue,
                  hint: Text(
                    "Select an option",
                    style: TextStyle(color: Colors.black),
                  ),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                  dropdownColor: Color(0xFF002244),
                  style: TextStyle(color: controller.selectedColor.value),
                  underline: SizedBox(), // Remove default underline
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                    controller.changeFont(selectedValue);
                  },
                  items: <String>['Roboto', 'Montserrat', 'OpenSans']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                child: Text(
                  "Change_Font".tr + " : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color:controller.selectedColor.value),
                ),
              ),
            ),
            Container(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: colors.map((color) {
                  return GestureDetector(
                    onTap: () {
                      controller.changeColor(color);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              padding: EdgeInsets.all(15),
            )
          ],
        ),
      ),
      appBar: AppBar(
        foregroundColor: controller.selectedColor.value,
        title: Text(
          "Everyone Welcome".tr,
          style: TextStyle(fontSize: 20,color: controller.selectedColor.value),
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
          IconButton(onPressed: () {
            Get.to(()=>NotificationPage());
          }, icon: Icon(Icons.notifications)),
       
        ],
      ),
    ));
  }
}
