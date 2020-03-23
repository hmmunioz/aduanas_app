

import 'package:aduanas_app/src/bloc/recovercode/recoverCodeBloc.dart';
import 'package:aduanas_app/src/bloc/recoveremail/recoveEmailBloc.dart';
import 'package:aduanas_app/src/bloc/tramitesscreen/tramiteBloc.dart';
import 'package:aduanas_app/src/bloc/utils/utilsBloc.dart';
import 'package:aduanas_app/src/repositories/repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:aduanas_app/src/validators/validators.dart';
import 'package:aduanas_app/src/bloc/login/loginSceenBloc.dart';
import 'changepassword/changePasswordBloc.dart';
import 'containerscreens/containerScreensBloc.dart';
import 'firebaseSmsService/smsServiceBloc.dart';

class Bloc with Validators{
  LoginScreenBloc login = new LoginScreenBloc();
  RecoverEmailBloc recoverEmail = new RecoverEmailBloc();
  RecoverCodeBloc recoverCode = new RecoverCodeBloc();
  UtilsBloc utilsBloc = new UtilsBloc();
  ChangePasswordBloc changePassword = new ChangePasswordBloc();
  ContainerScreensBloc containerScreens = new ContainerScreensBloc(); 
  SmsServiceBloc smsService = new SmsServiceBloc();
  TramiteBloc tramiteScreen = new TramiteBloc(); 
  Repository repository = new Repository();
  FlutterSecureStorage storage = new FlutterSecureStorage();

 void initTramiteUtils(){
    tramiteScreen.utilbloc = utilsBloc;
    tramiteScreen.containerScreensBloc = containerScreens;
    tramiteScreen.repository= repository;
 }

void initLoginScreen(){
    login.utilbloc = utilsBloc;  
    login.repository= repository;
    login.storage = storage;
 }

 void initSmsService(){
      smsService.blocEmailRecover= recoverEmail;
      smsService.blocSpinnerRecover= utilsBloc;
      smsService.blocCodeRecover=recoverCode;
  }
  //Clean memory
  dispose()
  {
      login.dispose();
      recoverEmail.dispose();
      recoverCode.dispose();
      changePassword.dispose();
      containerScreens.dispose();
      tramiteScreen.dispose();
      utilsBloc.dipose();  
  }
}