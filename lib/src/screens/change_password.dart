import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/models/password_model.dart';
import 'package:flutter_chat/src/widgets/appButton.dart';
import 'package:flutter_chat/src/widgets/appCurvedShape.dart';
import 'package:flutter_chat/src/widgets/appRoundIcon.dart';
import 'package:flutter_chat/src/widgets/appTextField.dart';
import 'package:flutter_chat/src/widgets/appTitle.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
 
  static const String routeName = "/changePassword";
  ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
 PasswordModel changePasswordText = new PasswordModel("", "");
  void setNewPass(String value, Bloc bloc){
     changePasswordText.setNewPassword= value;
    bloc.changePassword.changePassword(changePasswordText);  
    print( value);
  }
  void setRepeatNewPass(String value, Bloc bloc ){
  changePasswordText.setRepeatNewPassword= value;     
    bloc.changePassword.changePassword(changePasswordText);
    print(value);
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
                        height: 20.0,
                      ),
                      AppTextField(
                      
                        addObsucre: true,
                        onChanged:(value) => setNewPass(value, bloc) /* (value)=> setNewPass(value, bloc) */,
                        inputText: "NUEVA CONTRASEÑA",
                        inputIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        inputColor: Color.fromRGBO(142, 144, 146, 1),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      AppTextField(                         
                        addObsucre: true,
                        onChanged:(value) =>  setRepeatNewPass(value, bloc)/* (value, bloc) */,
                        inputText: "CONFIRMAR CONTRASEÑA",
                        inputIcon: Icon(Icons.vpn_key, color: Colors.white),
                        inputColor: Color.fromRGBO(142, 144, 146, 1),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      AppButton(
                        streamDataTransform: bloc.changePassword.getChangePassword,
                        color: Color.fromRGBO(255, 143, 52, 1),
                        name: "CAMBIAR",
                        invertColors: false,
                        context: context,
                        onPressed: () { sendNewCredentials(context, bloc);},
                      ),
                    ],
                  ),
                ),
              ],
            ))
      ],
    );
  }
}
