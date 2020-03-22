import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/src/bloc/containerscreens/containerScreensBloc.dart';
import 'package:flutter_chat/src/bloc/utils/utilsBloc.dart';
import 'package:flutter_chat/src/models/tramites_model.dart';
import 'package:flutter_chat/src/repositories/repository.dart';
import 'package:flutter_chat/src/services/dialog_service.dart';
import 'package:flutter_chat/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class TramiteBloc with Validators{

  ///TramiteBloc  
    UtilsBloc utilbloc;
    ContainerScreensBloc containerScreensBloc;
    Repository repository;
    TramiteBloc({this.utilbloc, this.containerScreensBloc, this.repository});
    List<TramiteModel> _porRecibirTramiteList = [];
    List<TramiteModel> _recibidosTramiteList = [];
    List<TramiteModel> _entregadosTramiteList = [];

 final _tramiteListController = BehaviorSubject<bool>();    
 final _tramitesList = BehaviorSubject<Future<dynamic>>();

 Function(bool) get addSinkTramiteList => _tramiteListController.sink.add; ////Set data to block TramiteScreen
 Stream<bool> get  changesTramiteList => _tramiteListController.stream.transform(validateTramiteObj);
 void changeTramiteState(BuildContext context, List listaActual, int position, int tipoTramite){
   var objetoActual = listaActual[position];
   listaActual.removeAt(position);
   tipoTramite==1 ? _recibidosTramiteList.add(objetoActual) : _entregadosTramiteList.add(objetoActual);
   addSinkTramiteList(true);
   utilbloc.changeSpinnerState(false);
   Navigator.of(context).pop();
   containerScreensBloc.changeActualScreen(1);
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

  void openDialog(BuildContext context, String contentError) async {
     final action =
      await Dialogs.yesAbortDialog(context, "Error", contentError, true, false);
      if (action == DialogAction.yes)
       {
          print("yesss");    
      } 
      else {  
           print("noffff");  
           Navigator.of(context).pop();
      }
  }

  List getPorRecibirList(){
     return _porRecibirTramiteList;
   }

  List getRecibidosList(){
     return _recibidosTramiteList;
   }

  List getEntregadosList(){
     return _entregadosTramiteList;
   }

  getTramitesByUser() async { 
    utilbloc.changeSpinnerState(true);
    repository.dbProvider.setInstanceTramite();
    dynamic listaTramitesTemp = await repository.dbProvider.dbProviderTramite.getTramites();
    _porRecibirTramiteList =listaTramitesTemp['porRecibir'];
    _recibidosTramiteList = listaTramitesTemp['recibidos'];
    _entregadosTramiteList = listaTramitesTemp['entregados'];
    addSinkTramiteList(true);
    utilbloc.changeSpinnerState(false);    
  }

  changeTramiteById(BuildContext context, TramiteModel tramiteObj) async {
     utilbloc.changeSpinnerState(true);
     dynamic resultChangeTramite = await repository.tramiteRepository.changeTramite(tramiteObj.getId, tramiteObj.getEstado);
     if(resultChangeTramite)
     {
      changeTramite(context, tramiteObj );

     }
     else{
       print("microerror");
     }
  }

  searchTramiteById(BuildContext context, String tramiteId ){
     int porRecibirExist = _porRecibirTramiteList.indexWhere((tramite) => tramite.getId== tramiteId); 
     int recibidoExist = _recibidosTramiteList.indexWhere((tramite) => tramite.getId== tramiteId); 
     int entregadoExist = _entregadosTramiteList.indexWhere((tramite) => tramite.getId== tramiteId);

     if(porRecibirExist!=-1){
      TramiteModel tramiteObjTemp =  _porRecibirTramiteList[porRecibirExist];
        return tramiteObjTemp;
    /*   changeTramiteById(context, tramiteObjTemp); */
     }
     else if(recibidoExist !=-1){
      TramiteModel tramiteObjTemp =  _recibidosTramiteList[recibidoExist];
        return tramiteObjTemp;  
     }
     else if(entregadoExist !=-1){
      TramiteModel tramiteObjTemp =  _entregadosTramiteList[entregadoExist];
        return tramiteObjTemp;
     }
     else{
        return null;
     }
  }

  

   dispose(){
      _tramiteListController.close();
      _tramitesList.close();
    }
}