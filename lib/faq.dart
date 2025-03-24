import 'package:deafproject/NotificationPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frequently Asked Questions".tr),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification action
              Get.to(()=>NotificationPage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "1. How can I use the service?".tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "You can use the service by signing up and logging into your account.".tr,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "2. What payment methods are available?".tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "We accept credit cards, PayPal, and many other payment methods.".tr,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "3. How can I contact customer support?".tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "You can reach out to us via the \"Contact Us\" page.".tr,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              "Note:".tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "If you have any other questions, feel free to contact us.".tr,
              style: TextStyle(fontSize: 14),
            ),
            Spacer(),
            
          ],
        ),
      ),
    );
  }
}
