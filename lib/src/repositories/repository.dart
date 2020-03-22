import 'package:flutter_chat/src/apiprovider/apiProvider.dart';
import 'package:flutter_chat/src/apiprovider/tramiteApiProvider.dart';
import 'package:flutter_chat/src/dbprovider/db_provider.dart';
import 'package:flutter_chat/src/models/tramites_model.dart';
import 'package:flutter_chat/src/repositories/autenticationRepository.dart';
import 'package:flutter_chat/src/repositories/tramiteRepository.dart';


class Repository {
    DBProvider dbProvider; 

  ApiProvider apiProvider =  ApiProvider.get();
  TramiteRepository tramiteRepository = TramiteRepository.get();
  AutenticationRepository autenticationRepository =  AutenticationRepository.get();
 
  Repository(){
   dbProvider = DBProvider.instance;
   apiProvider =  ApiProvider.get();
  tramiteRepository = TramiteRepository.get();
  autenticationRepository =  AutenticationRepository.get();
  initRepository();
  }
  void initRepository(){
     print("init repo");
      //dbProvider.init();
      tramiteRepository.tramiteApiProvider = apiProvider.tramiteApiProvider;    
      autenticationRepository.autenticationApiProvider= apiProvider.autenticationApiProvider;
      autenticationRepository.dbProvider= dbProvider;
  }


} 