import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String inputText;
  final String secondText;
  final bool  withAppBar;
  const AppTitle({this.inputText, this.secondText, this.withAppBar});
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
                Text(inputText,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 32.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
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
         Text(secondText,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 16.0,
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
