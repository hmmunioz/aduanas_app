import 'package:flutter_chat/src/apiprovider/tramiteApiProvider.dart';
import 'package:flutter_chat/src/models/tramites_model.dart';


class TramiteRepository {
   static final TramiteRepository _tramiteRepository = new TramiteRepository();
  
  static TramiteRepository get(){
    return _tramiteRepository;
  }

  TramiteApiProvider tramiteApiProvider;
  Future<dynamic> getTramites() => tramiteApiProvider.getTramites();
  Future<dynamic> changeTramite(String tramiteId, int estado) => tramiteApiProvider.changeTramite(tramiteId, estado);


}