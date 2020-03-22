import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/models/tramites_model.dart';
import 'package:flutter_chat/src/services/dialog_service.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

class ScanScreen extends StatefulWidget {
  static const String routeName = "/qrScannerCode";
  ScanScreen();
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  int banderadialog=0;
  int cont=0;
 void _settingModalBottomSheet(BuildContext context, dynamic objTramite, Bloc bloc, QRViewController controller) {
    var nameTramite = objTramite.getNumeroTramite;
    if(banderadialog==0){
      banderadialog++;
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return  Container(
            color: Colors.transparent,
            child:  Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                    borderRadius:  BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))),
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('Mas informacion'),
                        onTap: () => {}),
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text('Realizar Tramite'),
                      onTap:  () async {
                     final action =
                       await Dialogs.yesAbortDialog(context, nameTramite, '¿Esta seguro de realizar este trámite?', true, true);
                        if (action == DialogAction.yes) {
                           print("Si");
                           banderadialog=0;
                           bloc.tramiteScreen.changeTramiteById(context, objTramite);
                           controller.dispose();
                            //  bloc.tramiteScreen.changeTramiteList(objTramite.toString());
                        } else {           
                           banderadialog=0;               
                         print("No");
                         controller.dispose();
                        }
                      } ,
                    ),
                  ],
                )),
          );
        });
 
    }
     }

  
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<Bloc>(context);
    return Center(
      child:   Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("AS"),
                 Container(
            height: MediaQuery.of(context).size.height-86,
            child: QRView(
              key: qrKey,
              onQRViewCreated :(value)=> _onQRViewCreate(context, value, bloc),
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: Theme.of(context).primaryColor,
                borderLength: 30.0,
                borderWidth: 10.0,
                cutOutSize: 300,
              ),
            ),   
            
             )
              
              ],
            )
 
    );
  
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }  


  void _onQRViewCreate(BuildContext context, QRViewController controller, Bloc bloc) {

    this.controller = controller;
  
    controller.scannedDataStream.listen((scanData) {      
        TramiteModel objTramite = bloc.tramiteScreen.searchTramiteById(context, scanData);         
          if(objTramite!=null){
              _settingModalBottomSheet(context, objTramite, bloc, controller);    
              print("IF FINIHISH");      
         }      
    });
  }
}
