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
      return Positioned(child:Container(
      color: Color.fromRGBO(0, 0, 0, 0.8),
      child: Center(
       child: Column(
         mainAxisAlignment:MainAxisAlignment.center,
         children: <Widget>[
          SpinKitHourGlass(
            color:  Color.fromRGBO(255, 143, 52, 1),
            size: 80.0
          )
         ],
       ),
     ),
    )
   );
       }
    else{
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