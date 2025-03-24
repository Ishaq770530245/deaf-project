import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('help'.tr),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('how_can_we_help'.tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('need_assistance'.tr),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue),
              title: Text('email'.tr),
              subtitle: Text('email_address'.tr),
            ),
           
            ListTile(
              leading: Icon(Icons.help_outline, color: Colors.orange),
              title: Text('faq'.tr),
              subtitle: Text('faq_description'.tr),
            ),
          ],
        ),
      ),
    );
  }
}