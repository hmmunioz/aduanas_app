import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 500.0,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreate,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderColor: Color.fromRGBO(255, 143, 52, 1),
                borderLength: 30.0,
                borderWidth: 10.0,
                cutOutSize: 300,
              ),
            ),
          )
        ],
      ),
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
