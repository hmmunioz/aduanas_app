import 'dart:async';
import 'package:aduanas_app/src/bloc/utils/utilsBloc.dart';
import 'package:aduanas_app/src/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:http/http.dart' show Client, Response;
import 'dart:convert';

class TramiteApiProvider {
  static final TramiteApiProvider _tramiteApiProvider = new TramiteApiProvider();
  
    static TramiteApiProvider get(){
    return _tramiteApiProvider;
  }
  Client client = Client();
  final storage = new FlutterSecureStorage();
  final List<TramiteModel> _porRecibir = [];
  final List<TramiteModel> _recibidos = [];
  final List<TramiteModel> _entregados = [];
  Map<String, String> headers = {"Content-type":"application/json"};
 Future<bool> changeTramite(String tramiteId, int estado,  UtilsBloc utilsbloc, BuildContext context) async {
   if(estado<3){
     estado++;
   }
   dynamic objPostChangeTramite ={"id":tramiteId, "estado": estado }; 
    String urlApi= ConstantsApp.of(context).appConfig.base_url + ConstantsApp.of(context).urlServices.tramites['changeTramiteStatus'];  
   final response = await client.put("$urlApi", headers:headers, body:json.encode(objPostChangeTramite) );
   if (response.statusCode == 200) 
    {      
      if(json.decode(response.body)["exito"]==true)
      {
          return true;
      }
      else{
        //   utilsbloc.openDialog(context, "Usuario o Password incorrectos.", null,  true, false );
        return false;
      }
    }else{
      utilsbloc.changeSpinnerState(false);
       utilsbloc.openDialog(context, "Ha ocurrido un error.", response.body.toString(), null,  true, false );
        print(response.statusCode.toString());
        print(response.body.toString());
      throw Exception('---------------------------Failed to load post');
    } 
   }  
 
 
  Future<dynamic> getTramites(BuildContext context, UtilsBloc utilsbloc) async { 
   
     dynamic objPostGetTramites ={"usuarioId":await storage.read(key: 'jwt'), "fechaUltimSincronisacion":await storage.read(key: 'fechaSincroniza')!=null?await storage.read(key: 'fechaSincroniza'):""};       
     String urlApi= ConstantsApp.of(context).appConfig.base_url + ConstantsApp.of(context).urlServices.tramites['getAll'];  
    final response = await client.post("$urlApi", headers:headers, body:json.encode(objPostGetTramites) /* objPostGetTramites.toString() */);
print("respuesta de tramites");
    if (response.statusCode == 200) 
    {       
  print("traaamiteeees 2000");
       _porRecibir.clear();
       _recibidos.clear();
       _entregados.clear();
      json.decode(response.body)["asignados"]
          .map((tr) => !_porRecibir.contains(new TramiteModel.fromJson(tr))? _porRecibir.add(new TramiteModel.fromJson(tr)):print("Ya existe"))
          .toList();
   
      json.decode(response.body)["recibidos"]
          .map((tr) =>!_recibidos.contains(new TramiteModel.fromJson(tr))?  _recibidos.add(new TramiteModel.fromJson(tr)):print("Ya existe"))
          .toList();
     
      json.decode(response.body)["entregados"]
          .map((tr) =>!_entregados.contains(new TramiteModel.fromJson(tr))? _entregados.add(new TramiteModel.fromJson(tr)):print("Ya existe"))
          .toList(); 
          
     (json.decode(response.body)["fechaSincroniza"]!=""&& json.decode(response.body)["fechaSincroniza"]!=null)
     ? storage.write(key: 'fechaSincroniza', value: json.decode(response.body)["fechaSincroniza"].toString().split(' ')[0]+"T"+json.decode(response.body)["fechaSincroniza"].toString().split(' ')[1])
      :print("fechaVacia");
  
      dynamic responseData = {
        'porRecibir': _porRecibir,
        'recibidos': _recibidos,
        'entregados': _entregados
      };

      return responseData;
    } else {
        utilsbloc.changeSpinnerState(false);
        print(response.statusCode.toString());
        print(response.body.toString());
      // If that call was not successful, throw an error.
      throw Exception('---------------------------Failed to load post');
    }
 
       /*      }
    });   */

     }
}
