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
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  QRViewController controller;
  @override
  Widget build(BuildContext context) {
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
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }
}
