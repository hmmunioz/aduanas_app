import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;
  final String name;
  final bool invertColors;
  final Stream<dynamic> streamDataTransform;
  const AppButton(
      {this.color, this.onPressed, this.name, this.streamDataTransform, this.invertColors});
 
 Widget getButtonAction(VoidCallback onPressedMetod){
     return InkWell(
         onTap: onPressedMetod!=null ? onPressedMetod :null,
         child:   Padding(
      padding: EdgeInsets.symmetric(vertical: 13.0),
      child: Material(
          borderRadius: BorderRadius.circular(30.0),
         
          color: invertColors ? Colors.white : color,
          elevation: 5.0,
          child: SizedBox(
            width: 290.0,
            height: 43.0,
            child: FlatButton(
              
              child: Text(name,
                  style: TextStyle(fontSize: 18.0, color: invertColors ? color :Colors.white)),
              onPressed: null,
            ),
          )),
      ),
       );
 }
  Widget getButtonApp(AsyncSnapshot<dynamic> snapshot) 
  {
    if(snapshot!=null){
      if(snapshot.hasData){
        return getButtonAction(onPressed);
      }
      else{
       return getButtonAction(null);
      }            
    }
    else{
       return getButtonAction(onPressed);
     }
  }

  @override
  Widget build(BuildContext context) {
    if (streamDataTransform != null) {
      return StreamBuilder(
          stream: streamDataTransform,
          builder: (context, snapshot) {
            return getButtonApp(snapshot);
          });
    } else {
      return getButtonApp(null);
    }
  }
}
