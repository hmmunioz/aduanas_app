import 'package:flutter/material.dart';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/widgets/appButton.dart';
import 'package:aduanas_app/src/widgets/appCurvedShape.dart';
import 'package:aduanas_app/src/widgets/appRoundIcon.dart';
import 'package:aduanas_app/src/widgets/appSpinner.dart';
import 'package:aduanas_app/src/widgets/appTitle.dart';
import 'package:aduanas_app/src/widgets/appVerificationCode.dart';
import 'package:provider/provider.dart';

class RecoverPassCode extends StatefulWidget {
  static const String routeName = "/recoverpasscode";

  
  @override
  _RecoverPassCodeState createState() => _RecoverPassCodeState();
}

class _RecoverPassCodeState extends State<RecoverPassCode> {
  void validateCode(Bloc bloc, BuildContext context) {
    bloc.recoverCode.validateCode(context);
    /* Navigator.of(context).pushNamed("/changePassword"); */
   /*  bloc.utilsBloc.changeSpinnerState(true);
    bloc.smsService.signIn(context); */
  }
  
  @override
  Widget build(BuildContext context) {
     final bloc = Provider.of<Bloc>(context);
    return  OrientationBuilder(
        builder: (context, orientation) {
     return  Stack(
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
                   inputTextAnimation: true,
                   landscape: true,
                ),
             (orientation == Orientation.portrait?AppRoundIcon():SizedBox(height: 1.0,)),
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
                        onPressed: ()=> validateCode(bloc, context),
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
    );});
}
}
