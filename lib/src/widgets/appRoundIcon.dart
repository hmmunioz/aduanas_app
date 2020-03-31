import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';

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
        top: keyboardStateTemp== 1?   (MediaQuery.of(context).size.height / 15): (MediaQuery.of(context).size.height / 7.2) ,
        left: (MediaQuery.of(context).size.width / 2) - 65,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                width: 130.0,
                height: 130.0,
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
