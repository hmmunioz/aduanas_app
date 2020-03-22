import 'package:flutter_chat/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class UtilsBloc with Validators{
    ///Keyboard widget
    final _keyBoardController = BehaviorSubject<int>();
    Stream<int> get getKeyboardState => _keyBoardController.stream.transform(validateKeyboardState);
    Function(int) get changeKeyboardState => _keyBoardController.sink.add;  
    Function() get getValueKeyboardState =>  getDataKeyboardState(); 

    getDataKeyboardState(){
      final stateKeyboard = _keyBoardController.value;  
      print("data a mostrar $stateKeyboard");
      return stateKeyboard;
    }

     ///Spinner widget
     final _toggleSpinnerController = BehaviorSubject<bool>();  ////Trasnform inData to outData Spinner widget   
     Stream<bool> get getSpinnerState => _toggleSpinnerController.stream.transform(validateSpinnerState);    ////Set data to block Spinner widget
     Function(bool) get changeSpinnerState => _toggleSpinnerController.sink.add;

    dipose(){
      _keyBoardController.close();
      _toggleSpinnerController.close();
    }
}