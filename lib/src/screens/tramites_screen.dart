import 'package:flutter/material.dart';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/widgets/appCurvedShape.dart';
import 'package:aduanas_app/src/widgets/appTitleList.dart';
import 'package:aduanas_app/src/widgets/appTramiteCard.dart';
import 'package:provider/provider.dart';

class TramitesScreen extends StatelessWidget {
  TramitesScreen({Key key}) : super(key: key);
  static const String routeName = "/tramitesScreen";

  void showQrScreen(Bloc bloc) {
    bloc.containerScreens.changeActualScreen(5);
  }

  List<Widget> getTramiteList(int tipoTramite, Bloc bloc) {
    return (tipoTramite == 1
            ? bloc.tramiteScreen.getPorRecibirList()
            : (tipoTramite == 2
                ? bloc.tramiteScreen.getRecibidosList()
                : bloc.tramiteScreen.getEntregadosList()))
        .map((objTram) =>
            TramiteCard(objTramite:objTram, typeTramite: tipoTramite))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<Bloc>(context);
    bloc.initTramiteUtils();
    bloc.tramiteScreen.getTramitesByUser();
    return /* Column(children: <Widget>[ */
        Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                CurvedShape(),
                StreamBuilder(
                    stream: bloc.tramiteScreen.changesTramiteList,
                    builder: (context, snapshot) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            TitleList(
                                "Por Recibir",
                                bloc.tramiteScreen
                                    .getPorRecibirList()
                                    .length
                                    .toString()),
                            SizedBox(
                              height: 8.0,
                            ),
                            Column(children: getTramiteList(1, bloc)),
                            TitleList(
                                "Recibidos",
                                bloc.tramiteScreen
                                    .getRecibidosList()
                                    .length
                                    .toString()),
                            SizedBox(
                              height: 8.0,
                            ),
                            Column(children: getTramiteList(2, bloc)),
                            TitleList(
                                "Entregados",
                                bloc.tramiteScreen
                                    .getEntregadosList()
                                    .length
                                    .toString()),
                            SizedBox(
                              height: 8.0,
                            ),
                            Column(children: getTramiteList(3, bloc)),
                          ]);
                    })
              ],
            ),
            /*   */
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showQrScreen(bloc),
        child: Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );

    /*  ],)  ; */
  }
}
