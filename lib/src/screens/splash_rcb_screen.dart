import 'dart:async';
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
        flutterLocalNotificationsPlugin= new FlutterLocalNotificationsPlugin();
        var android = new AndroidInitializationSettings("@mipmap/ic_launcher");
        var iOS = new IOSInitializationSettings();
        var initSettings = new InitializationSettings(android, iOS);
        flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification:(value){print(value);} );
    
    redirectHomeOrLogin();
    Timer(Duration(seconds:10), ()=> Navigator.pushNamed(context, jwtTemp!=null?"/containerHome":"/login"));
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
     var android = new AndroidNotificationDetails('channel id', 'channel NAME', 'CHANNEL DESCRIPTION', );
     var iOS = new IOSNotificationDetails();
     var scheduledNotificationDateTime =  DateTime.now().add(Duration(seconds: 5));
     var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.schedule(0, 'Tienes Nuevos Tramites',"Click aqui para abrir los tramites", scheduledNotificationDateTime,platform );
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