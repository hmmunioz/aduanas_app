import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/constants/services_url.dart';
import 'package:flutter_chat/src/repositories/repository.dart';

import 'package:flutter_chat/src/screens/container_screens.dart';

import 'package:flutter_chat/src/screens/login_screen.dart';
import 'package:flutter_chat/src/screens/recoverpass_code.dart';
import 'package:flutter_chat/src/screens/recoverpass_email.dart';
import 'package:flutter_chat/src/screens/change_password.dart';
import 'package:provider/provider.dart';

Repository repository = new Repository();
  
 void main() {
  runApp(Provider<Bloc>(
      create: (context) => Bloc(),
      dispose: (context, bloc) => bloc.dispose(),
      child: UrlServices(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Color.fromRGBO(255, 143, 52, 1),
                  accentColor: Color.fromRGBO(142, 144, 146, 1),
                  canvasColor: Colors.transparent,
                  fontFamily: 'Montserrat',
                  textTheme: TextTheme(body1: TextStyle(color: Colors.white))),
              home:   /* (tk!="" && tk!=null) ?ContainerHome(): */LoginScreen(),
              routes: <String, WidgetBuilder> {
            LoginScreen.routeName: (BuildContext context)  =>  /* (tk!="" && tk!=null) ?ContainerHome(): */LoginScreen(),
            RecoverPassEmail.routeName: (BuildContext context) =>   RecoverPassEmail(),
            RecoverPassCode.routeName: (BuildContext context) => RecoverPassCode(),
            ChangePassword.routeName: (BuildContext context) =>   ChangePassword(),            
            ContainerHome.routeName: (BuildContext context) =>  /* (tk!="" && tk!=null) ? */ContainerHome()/* :LoginScreen() */,        
          }
         )
        )
       )
      );
}
