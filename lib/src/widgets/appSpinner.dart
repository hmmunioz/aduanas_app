import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class SpinnerLoading extends StatefulWidget {
  @override
  _SpinnerLoadingState createState() => _SpinnerLoadingState();
  final Stream<dynamic> streamDataTransform;
  SpinnerLoading({this.streamDataTransform});
}

class _SpinnerLoadingState extends State<SpinnerLoading> {
  Widget toggleSpinner(AsyncSnapshot snapshot){
    if(snapshot.data==true){
      print("opeeeen spinner");
      return Positioned(child:Container(
      color: Color.fromRGBO(0, 0, 0, 0.8),
      child: Center(
       child: Column(
         mainAxisAlignment:MainAxisAlignment.center,
         children: <Widget>[
          SpinKitHourGlass(
            color:Theme.of(context).primaryColor,
            size: 80.0
          )
         ],
       ),
     ),
    )
   );
       }
    else{
       print("close spinner");
      return SizedBox(height: 10.0,);
    }
  }
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder(
      stream: widget.streamDataTransform,
      builder:  (context, snapshot) {
            return toggleSpinner(snapshot);
          }
    );
  }
}