import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:flutter/material.dart';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/widgets/swipe_widget.dart';
import 'package:provider/provider.dart';

import 'appCardElementList.dart';
class TramiteCard extends StatefulWidget {
  @override
  _TramiteCardState createState() => _TramiteCardState();
  final TramiteModel objTramite;
  final int typeTramite;
  TramiteCard({this.objTramite, this.typeTramite});
}

class _TramiteCardState extends State<TramiteCard> {
  void _settingModalBottomSheet(context, TramiteModel objTramite, Bloc bloc) {
      bloc.utilsBloc.settingModalBottomSheet(context, objTramite,()=>{ bloc.tramiteScreen.changeTramiteById(context, objTramite)});
   }

   BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color:Colors.white /* Color.fromRGBO(142, 144, 146, 0.5) */,
      border: Border.all(
        color:Theme.of(context).accentColor , //                   <--- border color
        width:2.0,
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
                        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration:
                            myBoxDecoration(), //       <--- BoxDecoration here
                        child: OnSlide(items: <ActionItems>[
                           ActionItems(
                             backgroudColor: Colors.red,
                              icon:  IconButton(
                                icon:  Icon(Icons.menu ,color:Theme.of(context).primaryColor,),
                                onPressed: () {},
                                color: Theme.of(context).primaryColor,
                              ),
                              onPress: () {
                                _settingModalBottomSheet(context, widget.objTramite, bloc);
                              })
                        ], child: CardElementList(widget.objTramite, widget.typeTramite )
                        )                       
                      );              
  }
}