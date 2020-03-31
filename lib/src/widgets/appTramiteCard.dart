import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/services/dialog_service.dart';
import 'package:flutter_chat/src/widgets/swipe_widget.dart';
import 'package:provider/provider.dart';

import 'appCardElementList.dart';
class TramiteCard extends StatefulWidget {
  @override
  _TramiteCardState createState() => _TramiteCardState();
  final dynamic objTramite;
  TramiteCard({this.objTramite});
}

class _TramiteCardState extends State<TramiteCard> {
  void _settingModalBottomSheet(context, dynamic objTramite, Bloc bloc) {
    var nameTramite = objTramite['name'];
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return  Container(
            color: Colors.transparent,
            child:  Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))),
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('Mas informacion'),
                        onTap: () => {}),
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text('Realizar Tramite'),
                      onTap:  () async {
                     final action =
                       await Dialogs.yesAbortDialog(context, nameTramite, '¿Esta seguro de realizar este trámite?', true, true);
                        if (action == DialogAction.yes) {
                           print("Si");
                            bloc.tramiteScreen.changeTramite(context, objTramite);
                            //  bloc.tramiteScreen.changeTramiteList(objTramite.toString());
                        } else {                          
                         print("No");
                        }
                      } ,
                    ),
                  ],
                )),
          );
        });
  }

   BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      //color:  Color.fromRGBO(142, 144, 146,0.5),
      color: Color.fromRGBO(142, 144, 146, 0.5),
      border: Border.all(
        color: Color.fromRGBO(
            142, 144, 146, 1), //                   <--- border color
        width: 5.0,
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(25.0) //         <--- border radius here
          ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<Bloc>(context);
      return    Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(0.0),
                        decoration:
                            myBoxDecoration(), //       <--- BoxDecoration here
                        child: OnSlide(items: <ActionItems>[
                           ActionItems(
                              icon:  IconButton(
                                icon:  Icon(Icons.menu),
                                onPressed: () {},
                                color: Colors.white,
                              ),
                              onPress: () {
                                _settingModalBottomSheet(context, widget.objTramite, bloc);
                              })
                        ], child: CardElementList(widget.objTramite)
                        )                       
                      );              
  }
}