import 'dart:async';

import 'package:aduanas_app/src/bloc/utils/utilsBloc.dart';
import 'package:aduanas_app/src/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:http/http.dart' show Client, Response;
import 'dart:convert';

class AutenticationApiProvider {
  static final AutenticationApiProvider _autenticationApiProvider = new AutenticationApiProvider();
  static AutenticationApiProvider get(){
    return _autenticationApiProvider;
  }

  Client client = Client();
  Map<String, String> headers = {"Content-type":"application/json"};  
 Future<dynamic> singIn(String username, String password, String platformImei, UtilsBloc utilbloc, BuildContext context) async {
   
   dynamic objPostSingIn ={"username":username, "password": password, /* "imei":platformImei  */}; 
   String urlApi= ConstantsApp.of(context).appConfig.base_url + ConstantsApp.of(context).urlServices.autentication['singIn']; 
   final response = await client.post("$urlApi", headers:headers, body:json.encode(objPostSingIn) );

   if (response.statusCode == 200) 
    {    
         return json.decode(response.body);  
    
    }else{
    utilbloc.openDialog(context, "Ha ocurrido un error.", response.body.toString(), null,  true, false );
        print(response.statusCode.toString());
        print(response.body.toString());
      throw Exception('---------------------------Failed to load post');
    } 
   }  

}
