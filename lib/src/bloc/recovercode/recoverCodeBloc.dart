import 'package:flutter_chat/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class RecoverCodeBloc with Validators{

    final _codeRecoverController = BehaviorSubject<String>();  ///RecoverPassCodeScreen 
    Stream<String> get getCodeRecover => _codeRecoverController.stream.transform(validateCodeRecover);   ////Trasnform inData to outData RecoverPassCodeScreen
    Function(String) get changeCodeRecover => _codeRecoverController.sink.add;  ////Set data to block RecoverPassCodeScreen
   
    //RecoverPassCodeScreen Methods
    getDataCodeRecover(){
      final valueCodeRecover = _codeRecoverController.value;
      return valueCodeRecover;
    }
    dispose(){
        _codeRecoverController.close();
    }

}