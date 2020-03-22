import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_chat/src/models/tramites_model.dart';
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

  final _baseUrl = "http://192.168.5.118:9090/api/v1/tramite/all";
  final _changeTramitesrtr ="http://192.168.5.118:9090/api/v1/tramite/status";
  //final _baseUrl= "https://jsonplaceholder.typicode.com/posts";
 Future<dynamic> changeTramite(String tramiteId, int estado) async {
   if(estado<3){
     estado++;
   }
   dynamic objPostChangeTramite ={"id":tramiteId, "estado": estado }; 
   final response = await client.put("$_changeTramitesrtr", headers:headers, body:json.encode(objPostChangeTramite) /* objPostGetTramites.toString() */);
   if (response.statusCode == 200) 
    {      
      if(json.decode(response.body)["exito"]==true)
      {
          return true;
      }
      else{
        return false;
      }
    }else{
        print(response.statusCode.toString());
        print(response.body.toString());
      throw Exception('---------------------------Failed to load post');
    } 
   }  

  Future<dynamic> getTramites() async {   
    dynamic objPostGetTramites ={"usuarioId":9, "fechaUltimSincronisacion": "" };        
    final response = await client.post("$_baseUrl", headers:headers, body:json.encode(objPostGetTramites) /* objPostGetTramites.toString() */);

    if (response.statusCode == 200) 
    {       
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
          
     storage.write(key: 'fechaSincroniza', value: json.decode(response.body)["fechaSincroniza"]);

      dynamic responseData = {
        'porRecibir': _porRecibir,
        'recibidos': _recibidos,
        'entregados': _entregados
      };
    /*    _porRecibir.clear();
       _recibidos.clear();
       _entregados.clear(); */

      return responseData;
    } else {
        print(response.statusCode.toString());
        print(response.body.toString());
      // If that call was not successful, throw an error.
      throw Exception('---------------------------Failed to load post');
    }
  }
}
