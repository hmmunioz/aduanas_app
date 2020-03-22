import 'package:flutter_chat/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class RecoverPhoneBloc with Validators{
  ///RecoverPassPhoneScreen
    final _phoneRecoverController = BehaviorSubject<String>();
     ////Trasnform inData to outData RecoverPassPhoneScreen
    Stream<String> get getPhoneRecover => _phoneRecoverController.stream.transform(validatePhoneNumber);
    ////Get data to block RecoverPassPhoneScreen 
    Function(String) get getValuePhoneRecover => getDataPhoneRecover();
    ////Set data to block RecoverPassPhoneScreen
    Function(String) get changePhoneRecover => _phoneRecoverController.sink.add;
     //RecoverPassPhoneScreen Methods
    getDataPhoneRecover(){
      final valuePhoneRecover = _phoneRecoverController.value;       
      return valuePhoneRecover;
    }

    dispose(){
      _phoneRecoverController.close();
    }
}