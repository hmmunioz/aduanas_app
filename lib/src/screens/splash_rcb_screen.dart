import 'dart:async';
import 'dart:typed_data';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/widgets/animations/fancy_background.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
class SplashRcbScreen extends StatefulWidget {
          
  static const String routeName = "/splashRcbScreen";
  @override
  _SplashRcbScreenState createState() => _SplashRcbScreenState();
}

class _SplashRcbScreenState extends State<SplashRcbScreen> {
  

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
        Navigator.of(context).pushReplacementNamed("/login");
      }
    });      
  }

   void redirectHomeOrLogin()async{
       storage.read(key: "jwt").then((jwt){
         if(jwt!=null){
            jwtTemp=jwt;
         }else{
           jwtTemp=null;
         }
       });

   }

  @override
  Widget build(BuildContext context) {
     final bloc = Provider.of<Bloc>(context);
     bloc.initInstanceBlocs(); 
       bloc.tramiteScreen.addIsCompleteLoading(false);
        
      // showNotification();
    return FancyBackgroundDemo();
    }
    
}