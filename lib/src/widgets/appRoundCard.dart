import 'package:flutter/material.dart';

class AppRoundCard extends StatefulWidget {
  final String inputText;
  final Function onClick;
  final IconData iconCard;

  final Color inputColor;
  const AppRoundCard(
      {this.inputText, this.iconCard, this.inputColor, this.onClick});
  @override
  _AppRoundCardState createState() => _AppRoundCardState();
}

class _AppRoundCardState extends State<AppRoundCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      
      margin: EdgeInsets.only(left: 12.0, right: 12.0, top: 20.0, bottom: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      elevation: 4.0,
      child:/*  GestureDetector(
          onTap: () {
           
          },
          child: */ InkWell(
            onTap: () {
               widget.onClick();
            },
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  widget.iconCard,
                  size: 55.0,
                  color: widget.inputColor,
                ),
                Text(
                  widget.inputText,
                  style: TextStyle(color: widget.inputColor),
                ),
              ],
            )),
          )
          /* ), */
    );
  }
}
