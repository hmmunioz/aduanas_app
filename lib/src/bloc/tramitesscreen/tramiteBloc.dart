import 'dart:async';

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

  List<TramiteModel> getPorRecibirList(){
     return _porRecibirTramiteList;
   }

  List<TramiteModel> getRecibidosList(){
     return _recibidosTramiteList;
   }

  List<TramiteModel> getEntregadosList(){
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
    repository.tramiteRepository.changeTramite(tramiteObj.getId, tramiteObj.getEstado, utilbloc, context).then((resultChangeTramiteApi)=> 
      resultChangeTramiteApi!=null? repository.dbProvider.dbProviderTramite.updateTramite(tramiteObj).then((resultChangeTramiteDB)=> changeTramite(context, tramiteObj )):print("error")
    ).timeout( Duration (seconds:ConstantsApp.of(context).appConfig.timeout), onTimeout : () => utilbloc.openDialog(context, "Ha ocurrido un error.", "Intente de nuevo porfavor.", null, true, false ));   
    
  }

  /* void caseTramite(tramiteObjTemp){
      int porRecibirExist = _porRecibirTramiteList.indexWhere((tramite) => tramite.getId== tramiteId); 
                int recibidoExist = _recibidosTramiteList.indexWhere((tramite) => tramite.getId== tramiteId); 
                int entregadoExist = _entregadosTramiteList.indexWhere((tramite) => tramite.getId== tramiteId);

                if(porRecibirExist!=-1){
                  TramiteModel tramiteObjTemp =  _porRecibirTramiteList[porRecibirExist];
                    return tramiteObjTemp;
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
                   print("nuuuuuuuuuuuuuuuulsisioismo");
                } 
  } */

  void searchTramiteById(BuildContext context, String tramiteId ) async{
    print("tramiteeee iddaaaaa");
    print(tramiteId);
       repository.dbProvider.dbProviderTramite.getTramite(tramiteId).then((trm) {

         _settingModalBottomSheet(context, trm);
        /*  print(trm.getActividad); */
         return trm;
       } );
}      
        
    /**/
 void _settingModalBottomSheet(BuildContext context, TramiteModel objTramite) {
      var mensaje = "Tramite numero #" + objTramite.getNumeroTramite;
  
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return  Container(
            color: Colors.transparent,
            child:  Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))),
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('Mas informacion'),
                        onTap: () => {}),
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text('Realizar Tramite'),
                      onTap:  ()  async{  utilbloc.openDialog(context, mensaje, '¿Esta seguro de realizar este trámite?',  ()=>{changeTramiteById(context, objTramite)}, true, true); } ,  
                    ),
                  ],
                )),
          );
        }); 
     }
     
   dispose(){
      _tramiteListController.close();
      _tramitesList.close();
    }
}