import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../models/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<Box<NotificationModel>> _notificationBox;

  @override
  void initState() {
    super.initState();
    _notificationBox = _openNotificationBox();
  }

  Future<Box<NotificationModel>> _openNotificationBox() async {
    if (!Hive.isBoxOpen('notifications')) {
      return await Hive.openBox<NotificationModel>('notifications');
    }
    return Hive.box<NotificationModel>('notifications');
  }

  void _deleteNotification(Box<NotificationModel> box, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notification'),
        content: const Text('Are you sure you want to delete this notification?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              box.deleteAt(index);
              Navigator.of(context).pop(); // Close the dialog
              setState(() {}); // Rebuild the widget
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(title: Center(child: const Text('Notifications',style: TextStyle(color: Colors.blueAccent),)),backgroundColor: Colors.white,),
      body: FutureBuilder<Box<NotificationModel>>(
        future: _notificationBox,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final box = snapshot.data!;
          final notifications = box.values.toList();

          if (notifications.isEmpty) {
            return const Center(child: Text('No notifications.'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    notification.title,
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  subtitle: Text(
                    notification.body,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('yyyy-MM-dd – kk:mm').format(notification.timestamp),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteNotification(box, index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
