
import 'dart:typed_data';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/constants/constants.dart';
import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
class NotificationProvider{
  int temporalTime=15;
      NotificationProvider._privateConstructor();
      static final NotificationProvider instance = NotificationProvider._privateConstructor();   
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  void initNotificationProvider(BuildContext context, Bloc bloc){
       var android = new AndroidInitializationSettings("logologistic");
       var iOS = new IOSInitializationSettings();
        var initSettings = new InitializationSettings(android, iOS);  
        flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification:(String payload) async {
    if (payload != null) {
        print('notification payload: ' + payload);
        bloc.containerScreens.changeActualScreen(1);
        Navigator.pushReplacementNamed(context, "/splashRcbScreen");
    }

  });
  }


 void deleteNotification(TramiteModel tramiteModel){
   /* tramiteModel.getId */
   flutterLocalNotificationsPlugin.cancel(int.parse(tramiteModel.getId));
   print("Notificacion elminada "+ tramiteModel.getId);
   
 }
void showNotification(BuildContext context,  int type, TramiteModel tramiteModel )async {
  print("notificacioooon");
 var mensaje="El trámite #" + tramiteModel.getNumeroTramite +  " esta por caducarse";
 var tiempoEnvio =DateTime.parse(tramiteModel.getFechaRegistro).add(Duration(hours: -1));
 int minutesIncrement = 10;
 var dateTimeNow = DateTime.now().toLocal();
   var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
 /*     vibrationPattern[4] = 1000; */
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
     NotificationDetails platformChannelSpecifics = NotificationDetails(
    android, iOS);

     var scheduledNotificationDateTime = dateTimeNow.add(new Duration(seconds: minutesIncrement));
       await flutterLocalNotificationsPlugin.schedule(
         int.parse(tramiteModel.getId),   mensaje,   'Click aqui, para abrir los tramites.',
          scheduledNotificationDateTime,  platformChannelSpecifics,   payload: 'Custom_Sound',   );
}
}
