import 'package:flutter/material.dart';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/widgets/appButton.dart';
import 'package:aduanas_app/src/widgets/appCurvedShape.dart';
import 'package:aduanas_app/src/widgets/appRoundIcon.dart';
import 'package:aduanas_app/src/widgets/appSpinner.dart';
import 'package:aduanas_app/src/widgets/appTextField.dart';
import 'package:aduanas_app/src/widgets/appTitle.dart';
import 'package:provider/provider.dart';

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
   bloc.recoverEmail.changeEmailRecover(value);
  }
  void sendEmail(Bloc bloc, BuildContext context){  
    bloc.recoverEmail.sendEmail(context);
  }
  @override
  Widget build(BuildContext context) {
   
    final bloc = Provider.of<Bloc>(context);
    return  OrientationBuilder(
        builder: (context, orientation) {
                   return     Stack(
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
                            Text("Recuperar contraseña",
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
                      AppTextField(                 
                        addObsucre: false,
                        inputType: TextInputType.emailAddress,
                        streamDataTransform: bloc.recoverEmail.getEmailRecover,      
                        onChanged: (value)=> addEmailRecoverToSink(value, bloc),             
                        inputText: "CORREO ELECTRONICO",
                        inputIcon: Icon(
                          Icons.alternate_email,
                          color: Theme.of(context).accentColor,
                        ),
                        inputColor: Theme.of(context).accentColor,
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      AppButton(
                        streamDataTransform: bloc.recoverEmail.getEmailRecover,
                        color: Color.fromRGBO(255, 143, 52, 1),
                          invertColors: false,
                        name: "ENVIAR",
                        onPressed: ()=> sendEmail(bloc, context),
                        /* _con.submit() */
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
  });
 }
}
