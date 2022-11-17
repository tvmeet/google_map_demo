
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../Repository/Services/Navigation/navigation_service.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

///Handle fcm notifications appropriately in handleNotification method

class FirebaseMessagesHelper{
  static var pastMessage = null;
  static initFirebaseMessage()async{
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

   /* if(settings.authorizationStatus != AuthorizationStatus.authorized){
      await NotificationPermissions.requestNotificationPermissions(iosSettings: const NotificationSettingsIos(sound: true, badge: true, alert: true));
    }*/
    _firebaseMessaging.getToken().then((value) {
      print("#TOKEN $value");
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null){
        print(message.data);
        handleNotification(message,true);
      }
    });
    FirebaseMessaging.onMessage.listen((event) { });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage ${message.toMap().toString()} recieved ${message.data}");
      handleNotification(message,true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      handleNotification(message,false);
    });
    FirebaseMessaging.onBackgroundMessage((message) async {
      await Firebase.initializeApp();
      print('Handling a background message ${message.messageId}');
      print("onBackgroundMessage : ${message.toMap().toString()}");
      handleNotification(message,true);
    });
  }
  static handleNotification(RemoteMessage message,bool fireLocalNotification){
    print(message.toString());
    if(pastMessage != null && pastMessage == message){
      pastMessage = null;
      print("Return notification");
      return;
    }
    pastMessage = message;
    var context = NavigationService.navigatorKey.currentContext!;
    if (message.notification != null && fireLocalNotification) {
      sendLocalNotification(message.notification?.title??'', message.notification?.body??'',message.notification.hashCode);
    }
  }

  static sendLocalNotification(String title,String message,int id){
      if(title.isNotEmpty && message.isNotEmpty) {
        var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
      flutterLocalNotificationsPlugin.show(
          id,
          title,
          message,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'app_channel',
              'app_channel',
              importance: Importance.high,
              priority: Priority.high,
              icon: initializationSettingsAndroid.defaultIcon,
            ),
          ));
      }
    }
}