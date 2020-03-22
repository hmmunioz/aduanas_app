import 'package:flutter_chat/src/models/tramites_model.dart';
import 'package:sqflite/sqflite.dart';
class DBProviderTramite{
String tableName="tramites";
Future<Database> database;
DBProviderTramite({this.database});

Future<int> addTramite(TramiteModel tramiteModel) async{   
    Database db = await database;
    int idBdd = await db.insert(tableName,
    tramiteModel.toJson(),
    conflictAlgorithm: ConflictAlgorithm.replace,    
    );      
    return idBdd;
  } 
      
  Future<dynamic> getTramites() async{       
    Database db = await database;
     var maps = await db.query(tableName, 
      columns: null
     );
  
     if(maps.length > 0) {
      dynamic responseData = {
        'porRecibir':maps.map<TramiteModel>((tr)=> new TramiteModel.fromDb(tr)).where((tr)=>tr.getEstado==1).toList(),
        'recibidos': maps.map<TramiteModel>((tr)=> new TramiteModel.fromDb(tr)).where((tr)=>tr.getEstado==2).toList(),
        'entregados': maps.map<TramiteModel>((tr)=> new TramiteModel.fromDb(tr)).where((tr)=>tr.getEstado==3).toList(),
      };
      return responseData;
     }     
     return null;
   }

    Future<int> updateTramite(TramiteModel tramiteModel) async {
    print("Este es el estado");
    print(tramiteModel.getEstado);
    Database db = await database;
    tramiteModel.getEstado==1?tramiteModel.setEstado(2):tramiteModel.setEstado(3);    
    return await db.update(tableName, tramiteModel.toJson(),
        where: 'id = ?', whereArgs: [tramiteModel.getId]);
  }  
}