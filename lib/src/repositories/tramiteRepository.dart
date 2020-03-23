import 'package:aduanas_app/src/apiprovider/tramiteApiProvider.dart';
import 'package:aduanas_app/src/bloc/utils/utilsBloc.dart';
import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:flutter/cupertino.dart';


class TramiteRepository {
   static final TramiteRepository _tramiteRepository = new TramiteRepository();
  
  static TramiteRepository get(){
    return _tramiteRepository;
  }

  TramiteApiProvider tramiteApiProvider;
  Future<dynamic> getTramites(BuildContext context) => tramiteApiProvider.getTramites(context);
  Future<bool> changeTramite(String tramiteId, int estado, UtilsBloc utilbloc, BuildContext context) => tramiteApiProvider.changeTramite(tramiteId, estado, utilbloc, context );


}