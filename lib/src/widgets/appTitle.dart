import 'package:flutter/material.dart';

import 'appTypewriterBox.dart';

class AppTitle extends StatelessWidget {
  final String inputText;
  final String secondText;
  final bool inputTextAnimation;
  final bool secondTextAnimation;
  final bool  withAppBar;
  const AppTitle({this.inputText, this.secondText, this.withAppBar, this.inputTextAnimation, this.secondTextAnimation});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top:  withAppBar==true?(MediaQuery.of(context).size.height)*1/100:(MediaQuery.of(context).size.height)*5.5/100  ,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               inputTextAnimation!=false?   ApppTypeWriter(textWriter:inputText, textStyle:TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 25.0,
                  /*       fontFamily: 'Montserrat', */
                        color: Colors.white,
                        fontWeight: FontWeight.w700)): Text(inputText,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),

              /*   Text(inputText,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 32.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)), */
                secondTextShow()
              ],
            ),
          ),
        ));
  }

  Widget secondTextShow() {
    if (secondText != null) {
      return Column(
        children: <Widget>[
          secondTextAnimation!=false?
            ApppTypeWriter(textWriter:secondText, textStyle:TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)): Text(secondText,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
      
          SizedBox(
            height: 3.0,
          ),
        ],
      );
    } else {
      return SizedBox(
        height: 1.00,
      );
    }
  }
}
