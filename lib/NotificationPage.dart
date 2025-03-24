import 'package:deafproject/controller/SignLanguageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  SignLanguageController signLanguageController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.tr),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          NotificationTile(title: 'new_message'.tr, subtitle: 'new_message_subtitle'.tr, isRead: false),
          NotificationTile(title: 'update_available'.tr, subtitle: 'update_available_subtitle'.tr, isRead: true),
          NotificationTile(title: 'reminder'.tr, subtitle: 'reminder_subtitle'.tr, isRead: false),
          (signLanguageController.isresetPassord)?NotificationTile(title: 'Password_reset'.tr, subtitle: 'Password_reset_subtitle'.tr, isRead: false):SizedBox.shrink(),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isRead;

  const NotificationTile({required this.title, required this.subtitle, required this.isRead});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.white, width: 2.0),
      ),
      color: isRead ? Colors.grey[800] : Color(0xFF002244),
      child: ListTile(
        leading: Icon(Icons.notifications, color: isRead ? Colors.grey : Colors.white),
        title: Text(title.tr, style: TextStyle(fontWeight: isRead ? FontWeight.normal : FontWeight.bold, color: Colors.white)),
        subtitle: Text(subtitle.tr, style: TextStyle(color: Colors.white70)),
        trailing: Icon(Icons.arrow_forward_ios, size: 16.0, color: Colors.white),
        onTap: () {
          showDialog(
            
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Color(0xFF002244),
                title: Text(title.tr,style: TextStyle(color: Colors.white),),
                content: Text(subtitle.tr,style: TextStyle(color: Colors.white)),
                actions: [
                  TextButton(
                    
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK',selectionColor: Colors.white,style: TextStyle(color: Colors.white),),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
