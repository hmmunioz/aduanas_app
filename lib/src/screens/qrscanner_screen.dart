import 'package:flutter/material.dart';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:animated_qr_code_scanner/animated_qr_code_scanner.dart';
import 'package:animated_qr_code_scanner/AnimatedQRViewController.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatefulWidget {
  static const String routeName = "/qrScannerCode";
  ScanScreen();
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  int banderadialog=0;
  int cont=0;

  GlobalKey qrKey = GlobalKey();
  var qrText = "";
      final AnimatedQRViewController controller = AnimatedQRViewController();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<Bloc>(context);
    return Center(
      child:   Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20,),
                Text("Escanea el código QR", style: TextStyle(fontSize: 30.0, color: Theme.of(context).accentColor)),
                 Container(
            height: MediaQuery.of(context).size.height-130,
            child: AnimatedQRView(
              squareColor: Theme.of(context).primaryColor.withOpacity(0.25),
              animationDuration: const Duration(milliseconds: 600),
              onScan: (val){_onQRViewCreate(context, val, bloc); },       
              controller: controller )             
            
            )
            ]) 
    );
  
  }

  @override
  void dispose() {
    super.dispose();
  }  


  void _onQRViewCreate(BuildContext context, String value, Bloc bloc) {
    
    
     if(banderadialog==0){
        bloc.tramiteScreen.searchTramiteByNum(context, value, (){controller.pause(); controller.controller.resumeCamera(); controller.resume();}, bloc);
      banderadialog++;     
      }     
  }
}
