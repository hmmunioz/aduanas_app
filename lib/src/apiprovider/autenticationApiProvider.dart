import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'package:flutter_chat/src/models/tramites_model.dart';
import 'package:http/http.dart' show Client, Response;
import 'dart:convert';

class AutenticationApiProvider {
  static final AutenticationApiProvider _autenticationApiProvider = new AutenticationApiProvider();
  static AutenticationApiProvider get(){
    return _autenticationApiProvider;
  }

  Client client = Client();

  final List<TramiteModel> _porRecibir = [];
  final List<TramiteModel> _recibidos = [];
  final List<TramiteModel> _entregados = [];
  Map<String, String> headers = {"Content-type":"application/json"};

  final _baseUrl = "http://192.168.5.118:9090/api/v1/tramite/all";
  final _singIn ="http://192.168.5.118:9090/api/v1/login/all";
  //final _baseUrl= "https://jsonplaceholder.typicode.com/posts";
 Future<dynamic> singIn(String username, String password, String platformImei) async {
  
   dynamic objPostSingIn ={"username":username, "password": password, /* "imei":platformImei  */}; 
   final response = await client.post("$_singIn", headers:headers, body:json.encode(objPostSingIn) );
   if (response.statusCode == 200) 
    {    
         return json.decode(response.body);  
    
    }else{
        print(response.statusCode.toString());
        print(response.body.toString());
      throw Exception('---------------------------Failed to load post');
    } 
   }  

}
