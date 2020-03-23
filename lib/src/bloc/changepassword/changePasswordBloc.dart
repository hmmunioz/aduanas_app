import 'package:aduanas_app/src/models/password_model.dart';
import 'package:aduanas_app/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class ChangePasswordBloc with Validators{      
    final _equalPassController = BehaviorSubject<PasswordModel>();///ChangePasswordScreen
    Stream<bool> get getChangePassword => _equalPassController.stream.transform(validateEqualPassword);     ////Trasnform inData to outData ChangePasswordScreen
    Function(PasswordModel) get changePassword =>  _equalPassController.sink.add; ////Set data to block ChangePassword
    dispose(){
      _equalPassController.close();
    }
}