import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/widgets/appButton.dart';
import 'package:flutter_chat/src/widgets/appCurvedShape.dart';
import 'package:flutter_chat/src/widgets/appRoundIcon.dart';
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
    bloc.utilsBloc.changeSpinnerState(true);
    bloc.smsService.signIn(context);
  }
  
  @override
  Widget build(BuildContext context) {
     final bloc = Provider.of<Bloc>(context);
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                CurvedShape(),
                AppTitle(
                  inputText: "RCB logistic!",
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
                          length: 6,
                          focusColors: Theme.of(context).accentColor,
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
                        onPressed: ()=> goToChangePassword(bloc, context),
                      )
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
