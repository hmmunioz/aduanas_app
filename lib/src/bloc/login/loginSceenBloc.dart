import 'package:aduanas_app/src/constants/constants.dart';
import 'package:aduanas_app/src/services/dialog_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:aduanas_app/main.dart';
import 'package:aduanas_app/src/bloc/utils/utilsBloc.dart';
import 'package:aduanas_app/src/models/profile_model.dart';
import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:aduanas_app/src/repositories/repository.dart';
import 'package:aduanas_app/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Create storage

// Write value

class LoginScreenBloc with Validators {
  UtilsBloc utilbloc;
  Repository repository;
  ProfileModel profileModelRes;
  FlutterSecureStorage storage;

  String token;
  LoginScreenBloc({this.utilbloc, this.repository, this.profileModelRes, this.storage, this.token});

  ///LoginScreen
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _profileController= BehaviorSubject<ProfileModel>();
  ////Trasnform inData to outData LoginScreen
  Stream<String> get getEmail =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get getPass =>
      _passwordController.stream.transform(validatePass);
  Stream<bool> get submitValid =>
      Rx.combineLatest2(getEmail, getPass, (e, p) => true);
  ////Get data to block LoginScreen
  Function(String) get getValueEmail => getDataEmail();
  Function(String) get getValuePass => getDataPass();

  ////Set data to block LoginScreen
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passwordController.sink.add;
  Function(ProfileModel) get addSinkProfile => _profileController.sink.add;

  //Logic Bloc Methods
    getTokenSingIn() async {   
    token = await storage.read(key: 'jwt');
    return  token;
  }
  
  Future<ProfileModel> addProfileData() async{
      repository.dbProvider.setInstanceProfile();
      profileModelRes = await repository.dbProvider.dbProviderProfile.getProfile(); 
      addSinkProfile(profileModelRes);
      return profileModelRes;
  }  
  
  logOut(BuildContext context) async{
   await storage.deleteAll();
   repository.dbProvider.deleteDataBase();     
    Navigator.pushReplacementNamed(context, "/login");
  }

  singIn(Function singInOk, BuildContext context,) async {
    //firebaseToken();
    void singOk(Function addProfileSingInOk, String imei, String token) async {   
        repository.dbProvider.setInstanceProfile();
        repository.dbProvider.dbProviderProfile.getProfile().then((pf)=>{
             addProfileSingInOk(pf)
        });
     }   
  
    void addTramitesTolocalData(tramiteList) async{
     List<TramiteModel> _porRecibirTramiteList = tramiteList['porRecibir'];
     List<TramiteModel> _recibidosTramiteList = tramiteList['recibidos'];
     List<TramiteModel> _entregadosTramiteList = tramiteList['entregados']; 
     repository.dbProvider.setInstanceTramite();  
    _porRecibirTramiteList.forEach((f) =>  repository.dbProvider.dbProviderTramite.addTramite(TramiteModel.fromDb(f.toJson()))
     .then((idTramite)=>{
        idTramite>0 ? print(f.getActividad) :print("failed tramite ")                   
       })
     );

      _recibidosTramiteList.forEach((f) =>  repository.dbProvider.dbProviderTramite.addTramite(TramiteModel.fromDb(f.toJson()))
     .then((idTramite)=>{
        idTramite>0 ? print(f.getActividad) :print("failed tramite ")                   
       })
     );

      _entregadosTramiteList.forEach((f) =>  repository.dbProvider.dbProviderTramite.addTramite(TramiteModel.fromDb(f.toJson()))
     .then((idTramite)=>{
        idTramite>0 ? print(f.getActividad) :print("failed tramite ")                   
       })
     );
     singInOk();
  }

     void addProfileSingInOk(ProfileModel pf){
       profileModelRes =pf;
       addSinkProfile(profileModelRes);
       storage.write(key: 'jwt', value: profileModelRes.getUsuarioUUID);     
/*        ImeiPlugin.getImei( shouldShowRequestPermissionRationale: true ).then((imei)=>{          */ 
    /*     FirebaseAuth.instance.currentUser().then( (user) => {
          user!=null ? user.getIdToken().then((token) => */ repository.apiProvider.tramiteApiProvider.getTramites(context).then((tramiteList)=>{
                   addTramitesTolocalData(tramiteList) }).timeout(Duration (seconds:ConstantsApp.of(context).appConfig.timeout), onTimeout : () => utilbloc.openDialog(context, "Ha ocurrido un error.", "Intente de nuevo porfavor.", null, true, false ));                  
            /*  )  :  print("null")
          });        */
     /*   });     */        
    
    }    
     
     void singInResult(resultSingIn) async{
          print("comprobar logiiiiiiiiiiiiiiin"); 
        repository.dbProvider.setInstanceProfile();            
         resultSingIn!=null?repository
                     .dbProvider
                     .dbProviderProfile
                     .addProfile(ProfileModel.fromDb(resultSingIn[0]))
                     .then((idProfile)=>{
                      idProfile>0  ? singOk(addProfileSingInOk,"imei"," token.toString()" ) : print("error")
                    }):print("error");        
     }    
    
    utilbloc.changeSpinnerState(true);
    repository
        .apiProvider.autenticationApiProvider
        .singIn(getDataEmail(), getDataPass(), "platformImei", utilbloc, context).then((resultSingIn)=>{
              singInResult(resultSingIn)
        }).timeout( Duration (seconds:ConstantsApp.of(context).appConfig.timeout), onTimeout : () => utilbloc.openDialog(context, "Ha ocurrido un error.", "Intente de nuevo porfavor.", null, true, false ));   
  }
  

  Future<ProfileModel> getProfile() async {    
    repository.dbProvider.setInstanceProfile();
    profileModelRes =  await repository.dbProvider.dbProviderProfile.getProfile();
    addSinkProfile(profileModelRes);
    return profileModelRes;
  }

  getDataEmail() {
    String valueEmail = _emailController.value;
    return valueEmail;
  }

   getDataProfile() {
    ProfileModel valueProfile = _profileController.value;
    return valueProfile;
  }

  getDataPass() {
    String valuePass = _passwordController.value;
    return valuePass;
  }


  dispose() {
    _emailController.close();
    _passwordController.close();
    _profileController.close();
  }
}
