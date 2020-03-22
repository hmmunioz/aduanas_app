import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/widgets/appButton.dart';
import 'package:flutter_chat/src/widgets/appCurvedShape.dart';
import 'package:flutter_chat/src/widgets/appRoundIcon.dart';
import 'package:flutter_chat/src/widgets/appSpinner.dart';
import 'package:flutter_chat/src/widgets/appTitle.dart';
import 'package:flutter_chat/src/widgets/appVerificationCode.dart';
import 'package:provider/provider.dart';

class RecoverPassCode extends StatefulWidget {
  static const String routeName = "/recoverpasscode";

  
  @override
  _RecoverPassCodeState createState() => _RecoverPassCodeState();
}

class _RecoverPassCodeState extends State<RecoverPassCode> {
  void goToChangePassword(Bloc bloc, BuildContext context) {
    Navigator.of(context).pushNamed("/changePassword");
   /*  bloc.utilsBloc.changeSpinnerState(true);
    bloc.smsService.signIn(context); */
  }
  
  @override
  Widget build(BuildContext context) {
     final bloc = Provider.of<Bloc>(context);
    return   Stack(
      children: <Widget>[
               Scaffold(
                     resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                CurvedShape(),             
                  AppTitle(
                  inputText: "RCB logistic!",
                   withAppBar: false,
                ),
                AppRoundIcon(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 44.0),
                    height: MediaQuery.of(context).size.height/0.5,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.88,
                          ),                                  
                                  Text("Validación contraseña",
                                style: TextStyle(
                                    color:Theme.of(context).accentColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(
                              height: 2.0,
                            ),
                           SizedBox(
                        height: 20.0,
                      ),
                    VerificationCodeInput(
                          keyboardType: TextInputType.number,
                          bloc: bloc,
                          length: 5,
                          focusColors: Theme.of(context).primaryColor,
                          textStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),  
                          autofocus: true,
                          onCompleted: (String value) {
                             bloc.recoverCode.changeCodeRecover(value);
                          },
                        ),
                       SizedBox(
                        height: 7.0,
                      ),                     
                      AppButton(
                        streamDataTransform: bloc.recoverCode.getCodeRecover,
                        color:Theme.of(context).primaryColor,
                        name: "ENVIAR",
                       invertColors: false,
                        onPressed: ()=> goToChangePassword(bloc, context),
                      )
                         ],
                      ),
                    )
                   ),
              ],
            )
          ),
      SpinnerLoading(streamDataTransform: bloc.utilsBloc.getSpinnerState), 
      ],
    );
    
    
    
 /*    Stack(      
      children: <Widget>[
        Scaffold(
             resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                CurvedShape(),
                AppTitle(
                  inputText: "RCB logistic!",
                   withAppBar: false,
                ),
                AppRoundIcon(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 2.5),
                            Text("Validación contraseña",
                                style: TextStyle(
                                    color:Theme.of(context).accentColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700)),
                                 SizedBox(
                              height: 4.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: VerificationCodeInput(
                          keyboardType: TextInputType.number,
                          bloc: bloc,
                          length: 5,
                          focusColors: Theme.of(context).primaryColor,
                          textStyle: TextStyle(
                            color: Theme.of(context).accentColor,
                          ),  
                          autofocus: true,
                          onCompleted: (String value) {
                             bloc.recoverCode.changeCodeRecover(value);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),                     
                      AppButton(
                        streamDataTransform: bloc.recoverCode.getCodeRecover,
                        color:Theme.of(context).primaryColor,
                        name: "ENVIAR",
                       invertColors: false,
                        onPressed: ()=> goToChangePassword(bloc, context),
                      )
                    ],
                  ),
                ),
              ],
            )
        )    ,
        SpinnerLoading(streamDataTransform: bloc.utilsBloc.getSpinnerState),  
      ],
    );
  */ }
}
