import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
class TramiteDetail extends StatefulWidget {
  static const String routeName = "/tramiteDetail";
  @override
  _TramiteDetailState createState() => _TramiteDetailState();
}

class _TramiteDetailState extends State<TramiteDetail> {
  @override
  Widget build(BuildContext context) {    
    final bloc = Provider.of<Bloc>(context);
    TramiteModel tramiteModel = bloc.tramiteScreen.getValueTramiteDetail();
     String initials = tramiteModel.getResponsable.substring(0,1).toUpperCase() + " "+ tramiteModel.getResponsable.substring(1,2).toUpperCase() ;
     String fecha =  tramiteModel.getFechaRegistro.split("T")[0]!=null? tramiteModel.getFechaRegistro.split("T")[0]+" "+tramiteModel.getFechaRegistro.split("T")[1]:tramiteModel.getFechaRegistro;
    return Scaffold(   
      body: StreamBuilder(     
        initialData: false,
        stream: slimyCard.stream, 
        builder: ((BuildContext context, AsyncSnapshot snapshot) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(height: 200),
              SlimyCard(
                color: Theme.of(context).primaryColor,            
                topCardWidget: topCardWidget(tramiteModel, initials),
                bottomCardWidget: bottomCardWidget(tramiteModel, fecha),
              ),
            ],
          );
        }),
      ),
    );
  }
    Widget topCardWidget(TramiteModel tramiteModel, String initials) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         Text(
          "Tramite #"+ tramiteModel.getNumeroTramite,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),            
       SizedBox(height: 10),
       CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
               initials,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
        ),
        SizedBox(height: 5),
        Text(
          tramiteModel.getResponsable,
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
                      QrImage(
                foregroundColor: Colors.white,
                data: tramiteModel.getId,
                version: QrVersions.auto,
                size:(MediaQuery.of(context).size.height*16)/100 ,
              ),
              ],
    );
  }

  // This widget will be passed as Bottom Card's Widget.
  Widget bottomCardWidget(TramiteModel tramiteModel, String fecha) {
    return Column(
      children: <Widget>[
         Text(
          "Cliente",
          style: TextStyle(color: Colors.white, fontSize: 21),
        ),   
         Text(
        tramiteModel.getCliente,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
 /*        fontWeight: FontWeight.w500, */
      ),
      textAlign: TextAlign.center,
       ),
       
        Text(
      'Fecha: '+ fecha,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
       
      ),
      textAlign: TextAlign.center,
    ),
    Text(
          "Actividad",
          style: TextStyle(color:  Colors.white, fontSize: 19, ),
     ), 
     Text(
       tramiteModel.getActividad,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
    
      ),
      textAlign: TextAlign.center,
    )
      ],
    );  
  }
}
