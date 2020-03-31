import 'package:flutter/material.dart';
import 'package:flutter_chat/src/widgets/appMicroCircle.dart';

class CardElementList extends StatefulWidget {
  final dynamic element;
  CardElementList(this.element);
  @override
  _CardElementListState createState() => _CardElementListState();
}

class _CardElementListState extends State<CardElementList> {
  @override
  Widget build(BuildContext context) {
    return
    Card(
  elevation: 0,
  color: Colors.transparent,
 shape:RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft:Radius.circular(20) ,
      bottomRight: Radius.circular(20),
      topRight: Radius.circular(20),
      topLeft: Radius.circular(20),
      ),
    
   ),
  child:ListTile(      
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        title: Text(
          widget.element['name'],
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        subtitle: Text(
          widget.element['descripcion'],
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        trailing: MicroCircle(groupId: widget.element['groupId'])) 
    );
      }
}
