import 'package:flutter_chat/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginScreenBloc with Validators{
    ///LoginScreen 
    final _emailController = BehaviorSubject<String>();
    final _passwordController = BehaviorSubject<String>();       
    ////Trasnform inData to outData LoginScreen
    Stream<String> get getEmail => _emailController.stream.transform(validateEmail);
    Stream<String> get getPass => _passwordController.stream.transform(validatePass);
    Stream<bool> get submitValid => Rx.combineLatest2(getEmail, getPass, (e,p)=> true);   
    ////Get data to block LoginScreen 
    Function(String) get getValueEmail => getDataEmail();   
    Function(String) get getValuePass =>  getDataPass(); 

    ////Set data to block LoginScreen
    Function(String) get changeEmail => _emailController.sink.add;   
    Function(String) get changePass => _passwordController.sink.add;
   
    //Logic Bloc Methods
  
    getDataEmail(){
        final valueEmail = _emailController.value;  
        return valueEmail;
    }
    getDataPass(){
        final valuePass = _passwordController.value;
        return valuePass;
    }

      dispose(){
      _emailController.close();
      _passwordController.close();
    }
}