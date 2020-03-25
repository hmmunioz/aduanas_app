import 'dart:math';

import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:flutter/material.dart';
import 'package:aduanas_app/src/widgets/appMicroCircle.dart';

class CardElementList extends StatefulWidget {
  final TramiteModel tramiteModel;
  final int type;
  CardElementList(this.tramiteModel, this.type);
  @override
  _CardElementListState createState() => _CardElementListState();
}

class _CardElementListState extends State<CardElementList> {
  @override
  Widget build(BuildContext context) {
     var initials = widget.tramiteModel.getResponsable.substring(0,1).toUpperCase() + " " +widget.tramiteModel.getResponsable.substring(1,2).toUpperCase();
    
    return
     ListTile(    
       leading: CircleAvatar(
         radius: 25.0,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              initials,
              style: TextStyle(color: Colors.white),
            ),
          ),  
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        title: Text(
          "#"+widget.tramiteModel.getNumeroTramite,
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.bold, color:Theme.of(context).primaryColor),
        ),
        subtitle: Text(
          widget.tramiteModel.getActividad,
          style: TextStyle(fontSize: 18, color:Theme.of(context).accentColor),
        ),
        trailing: MicroCircle(groupId: widget.type)/* )  */
    );
      }
}
