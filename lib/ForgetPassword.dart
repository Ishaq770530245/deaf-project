import 'package:deafproject/controller/SignLanguageController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {

 String _selectedLanguage = "English";
 TextEditingController c = new TextEditingController();
 TextEditingController c2 = new TextEditingController();
 SignLanguageController signLanguageController = Get.find();
 bool isclicked = false;

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  child: Center(
                    child: Text(
                      "Forget Password".tr,
                      style: TextStyle(color: Colors.red, fontSize: 25),
                    ),
                  ),
                  width: Get.width * 8 / 10,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  child: Text(
                    "Enter Your Email".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  width: Get.width * 8 / 10,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  child: TextFormField(
                    controller: c,
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      hintText: "Enter Your Email".tr,
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
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  width: Get.width * 8 / 10,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              isclicked?Center(
                child: Container(
                  
                  child: Text(
                    "Enter Your Password".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  width: Get.width * 8 / 10,
                ),
              ):SizedBox.shrink(),
              isclicked?Center(
                child: Container(
                  child: TextFormField(
                    controller: c2,
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      hintText: "Enter Your Password".tr,
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
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  width: Get.width * 8 / 10,
                ),
              ):SizedBox.shrink(),
              Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      if(c.text != "")
                      {
                            if(!isclicked)
                          {
                            setState(() {
                              isclicked = true;
                            });
                          }else{
                            if(c2.text.isEmpty)
                             {
                               Get.snackbar("NOTIFICATION", "ENTER PASSWORD",backgroundColor: Colors.red);

                             }
                             else
                             {
                                if(!signLanguageController.isresetPassord)
                                {
                                  signLanguageController.isresetPassord = true;
                                }
                                Get.snackbar("NOTIFICATION", "PASSWORD RESET SUCCESS",backgroundColor: Colors.green);
                             }
                            
                           
                          }

                      }
                      else
                      {
                        Get.snackbar("NOTIFICATION", "ENTER EMAIL",backgroundColor: Colors.red);

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Reset Password'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  width: Get.width * 8 / 10,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Back To Login".tr,
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
