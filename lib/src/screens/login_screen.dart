import 'package:aduanas_app/src/widgets/appCurvedShape.dart';
import 'package:aduanas_app/src/widgets/appRoundIcon.dart';
import 'package:aduanas_app/src/widgets/appTitle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/models/profile_model.dart';
import 'package:aduanas_app/src/widgets/appButton.dart';
import 'package:aduanas_app/src/widgets/appSpinner.dart';
import 'package:aduanas_app/src/widgets/appTextField.dart';
import 'package:provider/provider.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/login";
  String token;
  String platformImeI;
  ProfileModel profileModel;
  final storage = new FlutterSecureStorage();
  LoginScreen({this.profileModel});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void initPhoneCredentials(BuildContext context) async {
    PermissionHandler()
        .requestPermissions([PermissionGroup.camera]).then((permisionCamera) {
      if (permisionCamera[PermissionGroup.camera].value == 1) {
        PermissionHandler()
            .requestPermissions([PermissionGroup.phone]).then((permisionPhone) {
          if (permisionPhone[PermissionGroup.phone].value == 1) {
            ImeiPlugin.getImei(shouldShowRequestPermissionRationale: true)
                .then((imei) async {
              await widget.storage.read(key: 'imei') == null
                  ? widget.storage.write(key: 'imei', value: imei)
                  : print("ya existe");
            });
            FirebaseAuth.instance.signInAnonymously().then((onValue) => {
                  FirebaseAuth.instance.currentUser().then((user) async {
                    user.getIdToken().then((token) async {
                      await widget.storage.read(key: 'firebaseToken') == null
                          ? widget.storage
                              .write(key: 'firebaseToken', value: token.token)
                          : print("ya existe");
                    });
                  })
                });
          } else {
            Navigator.pop(context);
          }
        });
      } else {
        Navigator.pop(context);
      }
    });
  }

  void singIn(Bloc bloc, BuildContext context) {
    bloc.login.singIn(okLogin, context);
  }

  void onChangedEmail(value, Bloc bloc) {
    bloc.login.changeEmail(value);
  }

  void onChangedPass(value, Bloc bloc) {
    bloc.login.changePass(value);
  }

  void okLogin() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        "/containerHome",
        (route) => route.isCurrent && route.settings.name == "/containerHome"
            ? true
            : false);
    //  Navigator.pushNamed(context, "/containerHome");
  }

  void failed() {
    print("failed");
  }

  Widget appRoundIconTemp(Bloc bloc) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            width:  (MediaQuery.of(context).size.height*17.5)/100,
            height:  (MediaQuery.of(context).size.height*17.5)/100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 5),
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("images/logoLogistic.png"))),
          ),
        ],
      ),
      /*  ) */
    );
  }

  Widget containerRecover(Bloc bloc, Orientation orientation) {
    return Container(
        padding: orientation != Orientation.landscape
            ? EdgeInsets.symmetric(horizontal: 24.0)
            : EdgeInsets.symmetric(horizontal: 20.0),
        height: orientation != Orientation.landscape
            ? MediaQuery.of(context).size.height / 0.5
            : ((MediaQuery.of(context).size.height) * 65) / 100,
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
               SizedBox(
                        height:((MediaQuery.of(context).size.height) * 30) / 100,
                      ),
               Text("Bienvenidos a RCB Logistic", style: TextStyle( fontSize: orientation==Orientation.portrait? 20.0:25.0, fontWeight: FontWeight.w700)),
                SizedBox(height: 20.0,),
              AppTextField(
                  addObsucre: false,
                  streamDataTransform: bloc.login.getEmail,
                  onChanged: (value) => onChangedEmail(value, bloc),
                  inputType: TextInputType.emailAddress,
                  inputText: "USUARIO",
                  inputIcon: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                  inputColor: Colors.white),
              SizedBox(
                height: 7.0,
              ),
              AppTextField(
                  streamDataTransform: bloc.login.getPass,
                  onChanged: (value) => onChangedPass(value, bloc),
                  inputType: TextInputType.visiblePassword,
                  addObsucre: true,
                  inputText: "PASSWORD",
                  inputIcon: Icon(
                    Icons.lock_open,
                    color: Colors.white,
                  ),
                  inputColor: Colors.white),
              SizedBox(
                height: 5.0,
              ),
              AppButton(
                streamDataTransform: bloc.login.submitValid,
                color: Theme.of(context).primaryColor,
                name: "INGRESAR",
                context: context,
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
            ])));
  }

  @override
  Widget build(BuildContext context) {
    initPhoneCredentials(context);
    void iniToken(BuildContext context, Bloc bloc) async {
      widget.profileModel = bloc.login.getDataProfile();
      widget.token = await widget.storage.read(key: 'jwt');
      if (widget.token != null && widget.token != "") {
        bloc.utilsBloc.changeSpinnerState(false);
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/containerHome",
            (route) =>
                route.isCurrent && route.settings.name == "/containerHome"
                    ? false
                    : true);
      } else {
        bloc.utilsBloc.changeSpinnerState(false);
      }
    }

    WidgetsFlutterBinding.ensureInitialized();

    final bloc = Provider.of<Bloc>(context);
    iniToken(context, bloc);
    bloc.utilsBloc.changeSpinnerState(true);
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible) {
          bloc.utilsBloc.changeKeyboardState(1);
        } else {
          bloc.utilsBloc.changeKeyboardState(0);
        }
      },
    );
    return
     OrientationBuilder(builder: (context, orientation) {
      return Stack(children: <Widget>[
        Image.asset(
          "images/celular.gif",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                 CurvedShape(transparent:true),
                  SizedBox(
                        height: 10.0,
                      ),
               /*  AppTitle( 
                  optionalfont:true,
                  inputText: "Bienvenidos a Aduanas App",
                  withAppBar: false,
                  inputTextAnimation: true,
                  landscape: true,
                ), */
                (orientation == Orientation.portrait
                    ? AppRoundIcon()
                    : SizedBox(
                        height: 1.0,
                      )),
                (orientation == Orientation.portrait
                    ? containerRecover(bloc, orientation)
                    : Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 4),
                        child: SingleChildScrollView(
                          child: containerRecover(bloc, orientation),
                        ))),
              ],
            )

            ),
        SpinnerLoading(streamDataTransform: bloc.utilsBloc.getSpinnerState),
      ]);
    });
  }
}
