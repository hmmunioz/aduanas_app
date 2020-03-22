import 'package:flutter/material.dart';
import 'package:flutter_chat/src/widgets/appMicroCircle.dart';

class CardElementList extends StatefulWidget {
  final dynamic element;
  final int type;
  CardElementList(this.element, this.type);
  @override
  _CardElementListState createState() => _CardElementListState();
}

class _CardElementListState extends State<CardElementList> {
  @override
  Widget build(BuildContext context) {
    return
     ListTile(      
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        title: Text(
          widget.element.getNumeroTramite,
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          widget.element.getActividad,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        trailing: MicroCircle(groupId: widget.type)/* )  */
    );
      }
}
