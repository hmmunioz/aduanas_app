


import 'package:flutter_chat/src/apiprovider/autenticationApiProvider.dart';
import 'package:flutter_chat/src/dbprovider/db_provider.dart';
import 'package:flutter_chat/src/models/profile_model.dart';

class AutenticationRepository {
  static final AutenticationRepository _autenticationRepository = new AutenticationRepository();
  AutenticationApiProvider autenticationApiProvider;
  DBProvider dbProvider;

  static AutenticationRepository get(){
    return _autenticationRepository
    ;
  }

   


}
