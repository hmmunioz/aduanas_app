import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MobileVerificationController extends ControllerMVC {
 
  String phoneNumber="";
  String smsCode;
  String verificationId;
  BuildContext context;
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController smsCodeController = TextEditingController(text: "");
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> submit() async {
/*     print("--------------------------------submit------------------------------");
    print(phoneNumber); */

    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential authCredential) {      
       Navigator.of(context).pushNamed("/recoverpasscode");
     print('verified');
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
       print(exception.code);
       print(exception.message);    
    };

    await FirebaseAuth.instance.verifyPhoneNumber( 
        phoneNumber: "+593${phoneNumber.substring(1)}",
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
        
  }

  signIn() {   
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    FirebaseAuth.instance.signInWithCredential(credential).then((user) {  
      ///CODIGO CORRECTO
      print("Codigo Correcto $user");    
    }).catchError((e) {
     print("Error $e");
    });
  }

}
