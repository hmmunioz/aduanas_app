import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/models/password_model.dart';
import 'package:flutter_chat/src/widgets/appButton.dart';
import 'package:flutter_chat/src/widgets/appCurvedShape.dart';
import 'package:flutter_chat/src/widgets/appRoundIcon.dart';
import 'package:flutter_chat/src/widgets/appSpinner.dart';
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
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                CurvedShape(),   
                  SizedBox(height: 10.0,),          
                  AppTitle(
                  inputText: "RCB logistic!",
                   withAppBar: false,
                ),
                AppRoundIcon(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 44.0),
                    height: MediaQuery.of(context).size.height/0.40,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.70,
                          ),                                  
                               Text("Recuperar contraseña",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w700)),
                          SizedBox(
                        height:20.0,
                         ),
                            AppTextField(                      
                        addObsucre: true,
                        onChanged:(value) => setNewPass(value, bloc) /* (value)=> setNewPass(value, bloc) */,
                        inputText: "NUEVA CONTRASEÑA",
                        inputIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        inputColor: Theme.of(context).accentColor,
                      ),
                SizedBox(
                  height: 10.0,
                ),
                  AppTextField(                         
                        addObsucre: true,
                        onChanged:(value) =>  setRepeatNewPass(value, bloc)/* (value, bloc) */,
                        inputText: "REPETIR CONTRASEÑA",
                        inputIcon: Icon(Icons.vpn_key, color: Colors.white),
                        inputColor: Theme.of(context).accentColor,
                      ),
                SizedBox(
                  height: 10.0,
                ),
                AppButton(
                        streamDataTransform: bloc.changePassword.getChangePassword,
                        color:Theme.of(context).primaryColor,
                        name: "CAMBIAR",
                        invertColors: false,
                        onPressed: () { print("CAMBIAAR CLAVEE");},
                      ),
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
  }
}
