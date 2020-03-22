import 'package:flutter_chat/src/apiprovider/autenticationApiProvider.dart';
import 'package:flutter_chat/src/apiprovider/tramiteApiProvider.dart';

class ApiProvider {
  
     static final ApiProvider _apiProvider = new ApiProvider();
 
    AutenticationApiProvider autenticationApiProvider = AutenticationApiProvider.get();
    TramiteApiProvider tramiteApiProvider =  TramiteApiProvider.get();

  static ApiProvider get(){
    return _apiProvider;
  }
}