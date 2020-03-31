import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/services/dialog_service.dart';
import 'package:flutter_chat/src/widgets/appCardElementList.dart';
import 'package:flutter_chat/src/widgets/appCurvedShape.dart';
import 'package:flutter_chat/src/widgets/appTitleList.dart';
import 'package:flutter_chat/src/widgets/appTramiteCard.dart';
import 'package:flutter_chat/src/widgets/swipe_widget.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';

/* List _elements = [
  {
    'name': 'Tramite N1',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 1...',
    'group': 'Por recibir',
    'groupId': 1
  },
  {
    'name': 'Tramite N3',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 2...',
    'group': 'Por recibir',
    'groupId': 1
  },
  {
    'name': 'Tramite N5',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 4...',
    'group': 'Entregados',
    'groupId': 3
  },
  {
    'name': 'Tramite N6',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 5...',
    'group': 'Entregados',
    'groupId': 3
  },
  {
    'name': 'Tramite N2',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 1...',
    'group': 'Recibidos',
    'groupId': 2
  },
  {
    'name': 'Tramite N4',
    'descripcion':
        'En este elemento se encuentra la inforamcion del tramite numero 3...',
    'group': 'Recibidos',
    'groupId': 2
  },
]; */

class TramitesScreen extends StatelessWidget {
  TramitesScreen({Key key}) : super(key: key);
  static const String routeName = "/tramitesScreen";

  void showQrScreen(Bloc bloc) {
    bloc.containerScreens.changeActualScreen(5);
  }

  Widget getTramiteList(int id, Bloc bloc) {  
    return Expanded(
        child: ListView.builder(
      itemCount: id==1 ? bloc.tramiteScreen.getPorRecibirList().length: (id==2 ?  bloc.tramiteScreen.getRecibidosList().length : bloc.tramiteScreen.getEntregadosList().length ),
      itemBuilder: (BuildContext context, int index) {
        return TramiteCard(
            objTramite:  id==1 ? bloc.tramiteScreen.getPorRecibirList()[index]: (id==2 ?  bloc.tramiteScreen.getRecibidosList()[index] : bloc.tramiteScreen.getEntregadosList()[index] ));               
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<Bloc>(context);
    //bloc.tramiteScreen.activateListener();
    var porRecibirLength = bloc.tramiteScreen.getPorRecibirList().length.toString();
    var recibidosLength = bloc.tramiteScreen.getRecibidosList().length.toString();
    var entregadosLegth = bloc.tramiteScreen.getEntregadosList().length.toString();
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              CurvedShape(),
              StreamBuilder(
                stream: bloc.tramiteScreen.changesTramiteList,
                builder: (context, snapshot) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      TitleList("Por Recibir", bloc.tramiteScreen.getPorRecibirList().length.toString()),
                      SizedBox(
                        height: 20.0,
                      ),
                      getTramiteList(1, bloc),
                      TitleList("Recibidos", bloc.tramiteScreen.getRecibidosList().length.toString()),
                      SizedBox(
                        height: 20.0,
                      ),
                      getTramiteList(2, bloc),
                      TitleList("Entregados", bloc.tramiteScreen.getEntregadosList().length.toString()),
                      SizedBox(
                        height: 20.0,
                      ),
                      getTramiteList(3, bloc)
                    ]);
              })
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showQrScreen(bloc),
            child: Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            backgroundColor: Color.fromRGBO(255, 143, 52, 1),
          ),
        )
      ],
    );
  }
}
