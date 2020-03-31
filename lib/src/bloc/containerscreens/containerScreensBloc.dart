import 'package:flutter_chat/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class ContainerScreensBloc with Validators{  
    final _actualScreenController = BehaviorSubject<int>(); ///ContainerScreens
    Stream<dynamic> get getActualScreen => _actualScreenController.stream.transform(validateActualScreens); ////Trasnform inData to outData ContainerScreens
    Function(int) get changeActualScreen => _actualScreenController.sink.add;////Set data to block ContainerScreens
     //ContainerScreens Methods
     getDataActualSceen(){
      final valueEmailRecover = _actualScreenController.value;
      return valueEmailRecover;
    }
    dispose(){
      _actualScreenController.close();
    }
}