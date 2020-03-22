import 'package:flutter_chat/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class RecoverEmailBloc with Validators{
  ///RecoverPassEmailScreen
    final _phoneRecoverController = BehaviorSubject<String>();
     ////Trasnform inData to outData RecoverPassEmailScreen
    Stream<String> get getEmailRecover => _phoneRecoverController.stream.transform(validateEmail);
    ////Get data to block RecoverPassEmailScreen 
    Function(String) get getValueEmailRecover => getDataEmailRecover();
    ////Set data to block RecoverPassEmailScreen
    Function(String) get changeEmailRecover => _phoneRecoverController.sink.add;
     //RecoverPassEmailScreen Methods
    getDataEmailRecover(){
      final valueEmailRecover = _phoneRecoverController.value;       
      return valueEmailRecover;
    }

    dispose(){
      _phoneRecoverController.close();
    }
}