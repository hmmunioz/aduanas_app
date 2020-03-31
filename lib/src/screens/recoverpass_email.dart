import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/controllers/mobile_verification_controller.dart';
import 'package:flutter_chat/src/widgets/appButton.dart';
import 'package:flutter_chat/src/widgets/appCurvedShape.dart';
import 'package:flutter_chat/src/widgets/appRoundIcon.dart';
import 'package:flutter_chat/src/widgets/appSpinner.dart';
import 'package:flutter_chat/src/widgets/appTextField.dart';
import 'package:flutter_chat/src/widgets/appTitle.dart';
import 'package:provider/provider.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
class RecoverPassEmail extends StatefulWidget {
  static const String routeName = "/recoverpassemail";
  
  @override
  _RecoverPassEmailState createState() => _RecoverPassEmailState();
}

class _RecoverPassEmailState extends State<RecoverPassEmail> {

  void goToCodeScreen() {
    
    Navigator.pushNamed(context, "/recoverpasscode");
  }
  void addEmailRecoverToSink(String value, Bloc bloc){
   bloc.recoverPhone.changePhoneRecover(value);
  }
  void sumbitSms(Bloc bloc, BuildContext context){
    bloc.smsService.submit(context);
  }
  @override
  Widget build(BuildContext context) {
   
    final bloc = Provider.of<Bloc>(context);
   bloc.init();
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
                  padding: EdgeInsets.symmetric(horizontal: 44.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 280.0,
                            ),
                            /*    ),    */
                            Text("Recuperar contraseña",
                                style: TextStyle(
                                    color: Color.fromRGBO(142, 144, 146, 1),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(
                              height: 2.0,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      AppTextField(
                     /*    controller: _con.phoneController, */
                        addObsucre: false,
                        inputType: TextInputType.emailAddress,
                        streamDataTransform: bloc.recoverPhone.getPhoneRecover,      
                        onChanged: (value)=> addEmailRecoverToSink(value, bloc),             
                        inputText: "NUMERO TELEFONICO",
                        inputIcon: Icon(
                          Icons.phone_android,
                          color: Color.fromRGBO(142, 144, 146, 1),
                        ),
                        inputColor: Color.fromRGBO(142, 144, 146, 1),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      AppButton(
                        streamDataTransform: bloc.recoverPhone.getPhoneRecover,
                        color: Color.fromRGBO(255, 143, 52, 1),
                          invertColors: false,
                        name: "ENVIAR",
                        onPressed: ()=> sumbitSms(bloc, context),
                        /* _con.submit() */
                      )
                    ],
                  ),
                ),
              ],
            )
          ),
        SpinnerLoading(streamDataTransform: bloc.utilsBloc.getSpinnerState), 
      ],
    );
  }
}
