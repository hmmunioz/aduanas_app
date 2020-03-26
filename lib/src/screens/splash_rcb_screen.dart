import 'dart:async';
import 'dart:typed_data';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/widgets/animations/fancy_background.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
class SplashRcbScreen extends StatefulWidget {
          
  static const String routeName = "/splashRcbScreen";
  @override
  _SplashRcbScreenState createState() => _SplashRcbScreenState();
}

class _SplashRcbScreenState extends State<SplashRcbScreen> {
  
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
    final storage = new FlutterSecureStorage();
    String jwtTemp;
  @override
  void initState(){
    super.initState();
     
    redirectHomeOrLogin();
    Timer(Duration(seconds:3), () {

      if(jwtTemp!=null){
              Navigator.of(context).pushNamedAndRemoveUntil(
              "/containerHome",
              (route) => route.isCurrent && route.settings.name == "/containerHome"
              ? false
              : true);
      }else{
        Navigator.of(context).pushNamedAndRemoveUntil(
              "/login",
              (route) => route.isCurrent && route.settings.name == "/login"
              ? false
              : true);
      }
    });      
  }
  void printvalue(String value) async{
    print("sssssssss");
   print(await value);
  }
/*   void showNotification()async {
     var android = new AndroidNotificationDetails('channel id', 'channel NAME', 'CHANNEL DESCRIPTION', );
     var iOS = new IOSNotificationDetails();
     var platform = new NotificationDetails(android, iOS);
     await flutterLocalNotificationsPlugin
  } */
   void redirectHomeOrLogin()async{
       storage.read(key: "jwt").then((jwt){
         if(jwt!=null){
            jwtTemp=jwt;
         }else{
           jwtTemp=null;
         }
       });

   }
   void showNotification()async {
 int minutesIncrement = 10;
var dateTimeNow = DateTime.now().toLocal();
   var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;

        
  var android = new AndroidNotificationDetails('channel id', 'channel NAME', 'CHANNEL DESCRIPTION', 
     color: Theme.of(context).primaryColor,
     enableVibration: true,
     vibrationPattern: vibrationPattern,

/*      ledColor: Theme.of(context).primaryColor, */

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
          0,
          'Tienes tramites por caducarse',
          'Click aqui, para abrir los tramites.',
          scheduledNotificationDateTime,
          platformChannelSpecifics,
           payload: 'Custom_Sound',
          );
    /* for(int i=1;i<=3;i++){

     
      minutesIncrement= minutesIncrement+5;
    }
 */



/* 



   

     var scheduledNotificationDateTime =  DateTime.now().add(Duration(seconds: 5));
     var platform = new NotificationDetails(android, iOS);
 
    await flutterLocalNotificationsPlugin.schedule(0, 'Tienes Nuevos Tramites',"Click aqui para abrir los tramites", scheduledNotificationDateTime,platformChannelSpecifics ); */
   //  await flutterLocalNotificationsPlugin.show(0, 'Tienes Nuevos Tramites',"Click aqui para abrir los tramites", platform );
  }


  @override
  Widget build(BuildContext context) {
     final bloc = Provider.of<Bloc>(context);
     bloc.initInstanceBlocs(); 
       bloc.tramiteScreen.addIsCompleteLoading(false);
        
       showNotification();
    return FancyBackgroundDemo();
    }
    
}