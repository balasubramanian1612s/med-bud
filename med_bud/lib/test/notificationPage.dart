import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        'channelId', 'reminderChannel', 'Send Reminders',
        importance: Importance.max, priority: Priority.max);
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    // await flutterLocalNotificationsPlugin.show(
    //     1, 'Task', 'You created', generalNotificationDetails,
    //     payload: "Payload");
    DateTime scheduledTime = DateTime.now()
        .add(Duration(seconds: 15)); // set the date and time of notification

    await flutterLocalNotificationsPlugin.schedule(0, 'Scheduled',
        'Scheduled Dude !1', scheduledTime, generalNotificationDetails,
        payload: 'Payload Info');
    //payload-the info you wanna pass at time of creating notification that should be recieved at time of notification
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Page'),
        backgroundColor: Colors.pink,
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            child: Text('Press'),
            onPressed: _showNotification,
          ),
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Notif clicked'),
        content: Text('Notification clicked $payload'),
      ),
    );
  }
}
