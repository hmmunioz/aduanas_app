import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/src/services/dialog_service.dart';
import 'package:flutter_chat/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class TramiteBloc with Validators{

  ///TramiteBloc  
    List _porRecibirTramiteList = [
  {
    'name': 'Tramite N1',
    'descripcion':
    'En este elemento se encuentra la inforamcion del tramite numero 1...',  
    'id': 1
  },
  {
    'name': 'Tramite N3',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 2...',
    'group': 'Por recibir',
    'id': 2
  },
  {
    'name': 'Tramite N5',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 4...',
    'group': 'Entregados',
    'id': 3
  },
  {
    'name': 'Tramite N6',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 5...',
    'group': 'Entregados',
    'id': 4
  },
  {
    'name': 'Tramite N2',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 1...',
    'group': 'Recibidos',
    'id': 5
  },
  {
    'name': 'Tramite N4',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 3...',
    'group': 'Recibidos',
    'id': 6
  },
];
    List _recibidosTramiteList = [];
    List _entregadosTramiteList = [];
 final _tramiteListController = BehaviorSubject<bool>();    
 Function(bool) get addSinkTramiteList => _tramiteListController.sink.add; ////Set data to block TramiteScreen
 Stream<bool> get  changesTramiteList => _tramiteListController.stream.transform(validateTramiteObj);
 void changeTramiteState(BuildContext context, List listaActual, int position, int tipoTramite){
   var objetoActual = listaActual[position];
   listaActual.removeAt(position);
   tipoTramite==1 ? _recibidosTramiteList.add(objetoActual) : _entregadosTramiteList.add(objetoActual);
   addSinkTramiteList(true);
   Navigator.of(context).pop();
 }
  void changeTramite(BuildContext context, dynamic tramiteObj)
  {   
     int porRecibirExist = _porRecibirTramiteList.indexWhere((tramite) => tramite['name']== tramiteObj['name']); 
     int recibidoExist = _recibidosTramiteList.indexWhere((tramite) => tramite['name']== tramiteObj['name']); 
     int entregadoExist = _entregadosTramiteList.indexWhere((tramite) => tramite['name']== tramiteObj['name']);   
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

   dispose(){
      _tramiteListController.close();
    }
}