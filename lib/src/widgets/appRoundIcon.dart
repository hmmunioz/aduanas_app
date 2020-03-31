import 'package:flutter/material.dart';
import 'package:aduanas_app/src/bloc/bloc.dart';

class AppRoundIcon extends StatelessWidget {
  final Stream<dynamic> streamDataTransform;
   final Bloc bloc;
  AppRoundIcon({this.streamDataTransform, this.bloc});
 
  @override
  Widget getRoundIconApp(BuildContext context, AsyncSnapshot<dynamic> snapshot){
   var keyboardStateTemp; 
    if(snapshot!=null && snapshot.hasData){
       keyboardStateTemp = bloc.utilsBloc.getDataKeyboardState();     
    }
   return  Positioned(
        top: keyboardStateTemp== 1?   (MediaQuery.of(context).size.height / 15): (MediaQuery.of(context).size.height / 10) ,
        left: (MediaQuery.of(context).size.width / 2) - 65,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                width:  (MediaQuery.of(context).size.height*17.5)/100,
                height: (MediaQuery.of(context).size.height*17.5)/100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 5),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("images/logoLogistic.png"))),
              ),
            ],
          ),
        )
        );
  
  }
  Widget build(BuildContext context) {
     if (streamDataTransform != null) {
      return StreamBuilder(
          stream: streamDataTransform,
          builder: (context, snapshot) {
            return getRoundIconApp(context, snapshot);
          });
    } else {
      return getRoundIconApp(context, null);
    }
    }
}
