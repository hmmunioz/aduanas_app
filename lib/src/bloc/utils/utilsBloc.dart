import 'package:aduanas_app/src/services/dialog_service.dart';
import 'package:aduanas_app/src/validators/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class UtilsBloc with Validators{
    ///Keyboard widget
    final _keyBoardController = BehaviorSubject<int>();
    Stream<int> get getKeyboardState => _keyBoardController.stream.transform(validateKeyboardState);
    Function(int) get changeKeyboardState => _keyBoardController.sink.add;  
    Function() get getValueKeyboardState =>  getDataKeyboardState(); 

    getDataKeyboardState(){
      final stateKeyboard = _keyBoardController.value;  
      return stateKeyboard;
    }
    
     ///Spinner widget
     final _toggleSpinnerController = BehaviorSubject<bool>();  ////Trasnform inData to outData Spinner widget   
     Stream<bool> get getSpinnerState => _toggleSpinnerController.stream.transform(validateSpinnerState);    ////Set data to block Spinner widget
     Function(bool) get changeSpinnerState => _toggleSpinnerController.sink.add;
 
     Future<Set<void>> openDialog(BuildContext context,String titleDialog, String contentDialog, Function singInOk, bool primaryButton, bool secondaryButton) async {
                     final action =
                       await Dialogs.yesAbortDialog(context, titleDialog, contentDialog, primaryButton, secondaryButton);
                        if (action == DialogAction.yes) 
                        {
                          singInOk();
                          print("ok");  
                        } else 
                        {    
                            print("canel");  
                        }
           }


    dipose(){
      _keyBoardController.close();
      _toggleSpinnerController.close();
    }
}