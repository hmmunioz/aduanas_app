
import 'dart:typed_data';
import 'package:aduanas_app/src/constants/constants.dart';
import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
class NotificationProvider{
      NotificationProvider._privateConstructor();
      static final NotificationProvider instance = NotificationProvider._privateConstructor();   
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  


void showNotification(BuildContext context,  int type, TramiteModel tramiteModel )async {
  var timeToNotification = DateTime.parse(tramiteModel.getFechaRegistro).add(Duration(hours: -1));

   var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

        
  var android = new AndroidNotificationDetails(ConstantsApp.of(context).appConfig.notificationChannels['id'], ConstantsApp.of(context).appConfig.notificationChannels['name'], ConstantsApp.of(context).appConfig.notificationChannels['description'], 
     color: Theme.of(context).primaryColor,
     enableVibration: true,
     vibrationPattern: vibrationPattern,
      importance: Importance.Max,
      priority: Priority.High,
       enableLights: true,        
        ledColor: Theme.of(context).primaryColor,
        ledOnMs: 1000,
        ledOffMs: 500
   );   

  var iOS = new IOSNotificationDetails();

     NotificationDetails platformChannelSpecifics = NotificationDetails(android, iOS);
       await flutterLocalNotificationsPlugin.schedule(
           int.parse(tramiteModel.getId),
           'Tienes tramites por caducarse',
          'Click aqui, para abrir los tramites.',
           timeToNotification,
           platformChannelSpecifics,
           payload: 'Custom_Sound',
          ); 
  }
}
