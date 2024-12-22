import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_maps/views/screens/pending_poetry_screen.dart';

import 'package:google_maps/views/screens/splash_screen.dart'; // import other screens here

class NotificationFile {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher_foreground');

    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse response) async {
      // This will be called when the notification is tapped
      if (response.payload != null) {
        // Parse the payload and navigate accordingly
        if (response.payload == 'pending') {
          Get.to(() => PendingPoetryScreen()); // Navigate to HomeScreen
        } else if (response.payload == 'splash') {
          Get.to(() => SplashScreen()); // Navigate to OtherScreen (replace with your desired screen)
        }
        // You can add more conditions here based on the payload to navigate to different screens
      }
    });
  }

  // Show a notification and include a payload to determine the navigation
  Future<void> showNotification(String title, String body, String screen) async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails('your_channel_id', 'your_channel_name', channelDescription: 'Your channel description', importance: Importance.max, priority: Priority.high, ticker: 'ticker', icon: 'launch_background');

    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

    // Pass the screen info as a payload
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      notificationDetails,
      payload: screen, // Passing screen as payload to navigate later
    );
  }
}
