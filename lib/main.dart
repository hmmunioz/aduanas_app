import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/screens/container_screens.dart';
import 'package:flutter_chat/src/screens/home_screen.dart';
import 'package:flutter_chat/src/screens/login_screen.dart';
import 'package:flutter_chat/src/screens/qrscanner_screen.dart';
import 'package:flutter_chat/src/screens/recoverpass_code.dart';
import 'package:flutter_chat/src/screens/recoverpass_email.dart';
import 'package:flutter_chat/src/screens/change_password.dart';

import 'package:flutter_chat/src/widgets/appSpinner.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(Provider<Bloc>(
      create: (context)=> Bloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: MaterialApp(
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromRGBO(255, 143, 52, 1),
          canvasColor: Colors.transparent,
          fontFamily: 'Montserrat',
          textTheme: TextTheme(body1: TextStyle(color: Colors.white))),
      home: Stack(
        children: <Widget>[          
           LoginScreen(),
         
        ],
      ) ,

      routes: <String, WidgetBuilder>{
        LoginScreen.routeName: (BuildContext context) => Stack(
        children: <Widget>[          
          LoginScreen(),
          SpinnerLoading(),
        ],
      ) ,
       
        RecoverPassEmail.routeName: (BuildContext context) => Stack(
        children: <Widget>[ 
          RecoverPassEmail(),
          SpinnerLoading(),
        ],
      ), 

        RecoverPassCode.routeName: (BuildContext context) => Stack(
        children: <Widget>[   
          RecoverPassCode(),
          SpinnerLoading(),
        ],
      ), 
    
        ChangePassword.routeName: (BuildContext context) => Stack(
        children: <Widget>[   
          ChangePassword(),
          SpinnerLoading(),
        ],
      ), 
      
        HomeScreen.routeName: (BuildContext context) =>  Stack(
        children: <Widget>[   
          ChangePassword(),
          SpinnerLoading(),
        ],
      ), 
       
        ContainerHome.routeName: (BuildContext context) => Stack(
        children: <Widget>[   
          ContainerHome(),
          SpinnerLoading(),
        ],
      ), 
        
       ScanScreen.routeName: (BuildContext context) =>  Stack(
        children: <Widget>[   
          ScanScreen(),
          SpinnerLoading(),
        ],
      ), 
       
      }))
);
}
