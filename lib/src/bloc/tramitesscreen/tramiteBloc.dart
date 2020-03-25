import 'dart:async';

import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:aduanas_app/src/bloc/containerscreens/containerScreensBloc.dart';
import 'package:aduanas_app/src/bloc/utils/utilsBloc.dart';
import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:aduanas_app/src/repositories/repository.dart';
import 'package:aduanas_app/src/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class TramiteBloc with Validators{

  ///TramiteBloc  
    UtilsBloc utilsbloc;
    ContainerScreensBloc containerScreensBloc;
    Repository repository;
    TramiteBloc({this.utilsbloc, this.containerScreensBloc, this.repository});
    List<TramiteModel> _porRecibirTramiteList = [];
    List<TramiteModel> _recibidosTramiteList = [];
    List<TramiteModel> _entregadosTramiteList = [];
    List<TramiteModel> _tempporRecibirTramiteList = [];
    List<TramiteModel> _temprecibidosTramiteList = [];
    List<TramiteModel> _tempentregadosTramiteList = [];

 final _tramiteListController = BehaviorSubject<bool>();    
 final _tramitesList = BehaviorSubject<Future<dynamic>>();
 final _tramiteDetailController = BehaviorSubject<TramiteModel>();
  final _isCompleteListLoadingController = BehaviorSubject<bool>();
  final _searchTramiteController = BehaviorSubject<String>();


 Function(bool) get addSinkTramiteList => _tramiteListController.sink.add; ////Set data to block TramiteScreen
 Stream<bool> get  changesTramiteList => _tramiteListController.stream.transform(validateTramiteObj);
Function(TramiteModel) get addSinkTramiteDetail => _tramiteDetailController.sink.add;
Function(bool) get addIsCompleteLoading => _isCompleteListLoadingController.sink.add;
Stream<bool> get  getTransformerIsCompleteLoading => _isCompleteListLoadingController.stream.transform(validateTramiteObj);

Function(String) get addSearchController => _searchTramiteController.sink.add;
/* Stream<String> get  getTransformerSearchController => _searchTramiteController.stream.transform(validateSearch);
 */String getSearchTramiteValue(){
   print(_searchTramiteController.value);   
  return _searchTramiteController.value;
}


bool getIsCompleteLoadingValue(){
  return _isCompleteListLoadingController.value;
}

 void changeTramiteState(BuildContext context, List listaActual, int position, int tipoTramite){
   var objetoActual = listaActual[position];
   listaActual.removeAt(position);
   tipoTramite==1 ? _recibidosTramiteList.add(objetoActual) : _entregadosTramiteList.add(objetoActual);
   addSinkTramiteList(true);
   utilsbloc.changeSpinnerState(false);
   Navigator.of(context).pop();
   containerScreensBloc.changeActualScreen(1);
 }
 TramiteModel getValueTramiteDetail(){
   return _tramiteDetailController.value;
 }
  void changeTramite(BuildContext context, TramiteModel tramiteObj)
  {   
     int porRecibirExist = _porRecibirTramiteList.indexWhere((tramite) => tramite.getId== tramiteObj.getId); 
     int recibidoExist = _recibidosTramiteList.indexWhere((tramite) => tramite.getId== tramiteObj.getId); 
     int entregadoExist = _entregadosTramiteList.indexWhere((tramite) => tramite.getId== tramiteObj.getId);   
     int tipoTramite = (porRecibirExist!= null && porRecibirExist!= -1)? 1 : ((recibidoExist!= null && recibidoExist!= -1)?2: ((entregadoExist!= null && entregadoExist!= -1)?3:-1));
     int posicionTramite = (porRecibirExist!= null && porRecibirExist!= -1)? porRecibirExist : ((recibidoExist!= null && recibidoExist!= -1)?recibidoExist: ((entregadoExist!= null && entregadoExist!= -1)?entregadoExist:-1));
     
    if(tipoTramite!=null && tipoTramite!=-1){
       switch (tipoTramite) {
         case 1 : 
          return changeTramiteState(context, _porRecibirTramiteList, posicionTramite, tipoTramite);
         case 2 :
          return changeTramiteState(context, _recibidosTramiteList, posicionTramite, tipoTramite);
         case 3 :
          return changeTramiteState(context, _entregadosTramiteList, posicionTramite, tipoTramite);
           break;
         default:
       }

     }
  }

 
  List<TramiteModel> getPorRecibirList(){
     return  (getSearchTramiteValue()=="" || getSearchTramiteValue()==null)? _porRecibirTramiteList:_porRecibirTramiteList.where((tr) =>  tr.getNumeroTramite.contains(getSearchTramiteValue())).toList();
    }

  List<TramiteModel> getRecibidosList(){
     return  (getSearchTramiteValue()=="" || getSearchTramiteValue()==null)?  _recibidosTramiteList:_recibidosTramiteList.where((tr) =>  tr.getNumeroTramite.contains(getSearchTramiteValue())).toList();
   }

  List<TramiteModel> getEntregadosList(){
     return (getSearchTramiteValue()=="" || getSearchTramiteValue()==null)? _entregadosTramiteList : _entregadosTramiteList.where((tr) =>  tr.getNumeroTramite.contains(getSearchTramiteValue())).toList();
   }
  

   refreshAddTramites(tramiteList, BuildContext context){

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

     utilsbloc.changeSpinnerState(false);
    // Navigator.pop(context);          
   }

   refreshTramites(BuildContext context,){

    repository.apiProvider.tramiteApiProvider.getTramites(context, utilsbloc).then((tramiteList)=>{
                   refreshAddTramites(tramiteList, context  ) });/* .timeout(Duration (seconds:ConstantsApp.of(context).appConfig.timeout), onTimeout : () => utilsbloc.openDialog(context, "Ha ocurrido un error.", "Intente de nuevo porfavor.", null, true, false )); */
   }

  getTramitesByUser() async { 
    utilsbloc.changeSpinnerState(true);
    repository.dbProvider.setInstanceTramite();
    dynamic listaTramitesTemp = await repository.dbProvider.dbProviderTramite.getTramites();
    _porRecibirTramiteList =listaTramitesTemp['porRecibir'];
    _recibidosTramiteList = listaTramitesTemp['recibidos'];
    _entregadosTramiteList = listaTramitesTemp['entregados'];
    addSinkTramiteList(true);
    utilsbloc.changeSpinnerState(false);    
  }

  changeTramiteById(BuildContext context, TramiteModel tramiteObj) async {
     utilsbloc.changeSpinnerState(true);   
    repository.tramiteRepository.changeTramite(tramiteObj.getId, tramiteObj.getEstado, utilsbloc, context).then((resultChangeTramiteApi)=> 
      (resultChangeTramiteApi!=false && resultChangeTramiteApi!=null)? repository.dbProvider.dbProviderTramite.updateTramite(tramiteObj).then((resultChangeTramiteDB)=> changeTramite(context, tramiteObj )):print("error")
    ).timeout( Duration (seconds:ConstantsApp.of(context).appConfig.timeout), onTimeout : () => utilsbloc.openDialog(context, "Ha ocurrido un error.", "Intente de nuevo porfavor.", null, true, false ));   
    
  }

  void searchTramiteByNum(BuildContext context, String tramiteNum, Function controllerReset, Bloc bloc ) async{
    print("tramiteeee iddaaaaa");

       repository.dbProvider.dbProviderTramite.getTramite(tramiteNum).then((trm) {
          
        trm!=null?utilsbloc.settingModalBottomSheet(context, trm,(){controllerReset(); changeTramiteById(context, trm);})
        :utilsbloc.openDialog(context, "Ha ocurrido un error","El tramite que busca no existe.", ()=> bloc.containerScreens.changeActualScreen(1), true, false) ;
       
       } );
}      
        

   dispose(){
      _tramiteListController.close();
      _tramitesList.close();
      _isCompleteListLoadingController.close();
      _tramiteDetailController.close();
      _searchTramiteController.close();
    }
}