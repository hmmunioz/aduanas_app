import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  final String inputText;
  final String secondText;
  const AppTitle({this.inputText, this.secondText});
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height/15,
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
          SizedBox(
            height: 10.0,
          ),
          Text(secondText,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 18.0,
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
