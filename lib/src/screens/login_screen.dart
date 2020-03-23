
import 'package:flutter/material.dart';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/models/profile_model.dart';
import 'package:aduanas_app/src/widgets/appButton.dart';
import 'package:aduanas_app/src/widgets/appRoundIcon.dart';
import 'package:aduanas_app/src/widgets/appSpinner.dart';
import 'package:aduanas_app/src/widgets/appTextField.dart';
import 'package:provider/provider.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {

  static const String routeName = "/login";
     String token;
       String platformImeI;
       ProfileModel profileModel;
    final storage = new FlutterSecureStorage();
  /* LoginScreen({Key key}) : super(key: key); */
LoginScreen({this.profileModel});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void singIn(Bloc bloc, BuildContext context){
       bloc.login.singIn(okLogin ,context);
  }
  void onChangedEmail(value, Bloc bloc) {
    bloc.login.changeEmail(value);
  }
   void onChangedPass(value , Bloc bloc) {
   bloc.login.changePass(value);
  }
  void okLogin(){
   Navigator.pushNamed(context, "/containerHome");
  }
  void failed(){
    print("failed");
  }
  @override
  Widget build(BuildContext context) {      
   void iniToken(BuildContext context, Bloc bloc)async{
    widget.profileModel =  bloc.login.getDataProfile();   
    widget.token=await  widget.storage.read(key: 'jwt') ;
    if(widget.token!=null &&  widget.token!="" ){
         bloc.utilsBloc.changeSpinnerState(false);
         
        Navigator.pushReplacementNamed(context, "/containerHome");
    }    
    else{
        bloc.utilsBloc.changeSpinnerState(false);
    }
  }
    WidgetsFlutterBinding.ensureInitialized();
    final bloc = Provider.of<Bloc>(context);
     bloc.initLoginScreen(); 
    iniToken(context, bloc);   
    bloc.utilsBloc.changeSpinnerState(true); 
    KeyboardVisibilityNotification().addNewListener(
    onChange: (bool visible) {
      if(visible)
      {
         bloc.utilsBloc.changeKeyboardState(1);
      }
      else{
           bloc.utilsBloc.changeKeyboardState(0);
      }
     
    },
  );
    return  Stack(
      children: <Widget>[            
        Image.asset(
          "images/backgroundPages.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      
        AppRoundIcon(streamDataTransform: bloc.utilsBloc.getKeyboardState, bloc: bloc,),
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: 
            Container(
            padding: EdgeInsets.symmetric(horizontal: 34.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[                
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[                               
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      Text("Bienvenidos a RCB Logistic",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700)),
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
                     addObsucre: false,
                    streamDataTransform: bloc.login.getEmail ,
                    onChanged: (value) => onChangedEmail(value, bloc),
                    inputType: TextInputType.emailAddress,
                    inputText: "USUARIO",
                    inputIcon: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                    inputColor: Colors.white),
                SizedBox(
                  height: 10.0,
                ),
                AppTextField(
                   streamDataTransform: bloc.login.getPass ,
                    onChanged:(value) => onChangedPass(value, bloc) ,
                    inputType: TextInputType.visiblePassword,
                    addObsucre: true,
                    inputText: "PASSWORD",
                    inputIcon: Icon(
                      Icons.lock_open,
                      color: Colors.white,
                    ),
                    inputColor: Colors.white),
                SizedBox(
                  height: 10.0,
                ),
                AppButton(
                  streamDataTransform: bloc.login.submitValid,
                  color: Theme.of(context).primaryColor,
                  name: "INGRESAR",
                    invertColors: false,
                  onPressed: () {
                      singIn(bloc, context);              
                  },
                ),
                Center(
                    child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/recoverpassemail");
                  },
                  child: Text(
                    "¿Olvidaste tu contraseña?",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ))
              ],
            ),
          ),  
        ),
     SpinnerLoading(streamDataTransform: bloc.utilsBloc.getSpinnerState),     
      ],
    );   
    
    }
}
