import 'package:aduanas_app/src/bloc/tramitesscreen/tramiteBloc.dart';
import 'package:aduanas_app/src/models/tramites_model.dart';
import 'package:aduanas_app/src/screens/tramite_detail_screen.dart';
import 'package:aduanas_app/src/services/dialog_service.dart';
import 'package:aduanas_app/src/validators/validators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class UtilsBloc with Validators{
  TramiteBloc tramiteBloc;
  UtilsBloc({this.tramiteBloc});
    ///Keyboard widget
    
    final _keyBoardController = BehaviorSubject<int>();
    Stream<int> get getKeyboardState => _keyBoardController.stream.transform(validateKeyboardState);
    Function(int) get changeKeyboardState => _keyBoardController.sink.add;  
    Function() get getValueKeyboardState =>  getDataKeyboardState(); 

    getDataKeyboardState(){
      final stateKeyboard = _keyBoardController.value;  
      return stateKeyboard;
    }
     
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
  

 void showTramiteDetail(TramiteModel tramiteModel, BuildContext context){
     Navigator.pop(context);
      tramiteBloc.addSinkTramiteDetail(tramiteModel);
        Navigator.of(context).push(PageRouteBuilder(
           barrierColor: Colors.black.withOpacity(0.6),
            opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
        TramiteDetail()));
 }


   void settingModalBottomSheet(BuildContext context, TramiteModel objTramite, Function changeTramite) {
      var mensaje = "Tramite numero #" + objTramite.getNumeroTramite;  
      showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (builder) {
          return  Container(
            color: Colors.transparent,
            child:  Container(
                decoration:  BoxDecoration(
                    color: Colors.white,
                           /*    border: Border(

                    top: BorderSide( color:Theme.of(context).primaryColor,
                      width:2.0),
                    left:  BorderSide( color:Theme.of(context).primaryColor,
                      width:2.0),
                    right:  BorderSide( color:Theme.of(context).primaryColor,
                      width:2.0),
                  ),    
                                  */
                    borderRadius:  BorderRadius.only(
                        topLeft: const Radius.circular(25.0),
                        topRight: const Radius.circular(25.0))),
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text('Mas informacion'),
                        onTap: () => {showTramiteDetail(objTramite, context)}),
                    ListTile(
                      leading: Icon(Icons.check),
                      title: Text('Realizar Tramite'),
                      onTap:  ()  async{ openDialog(context, mensaje, '¿Esta seguro de realizar este trámite?',  ()=>{changeTramite()/* changeTramiteById(context, objTramite) */}, true, true); } ,  
                    ),
                    ListTile(
                      leading: Icon(Icons.cancel),
                      title: Text('Salir'),
                      onTap:  ()=>{Navigator.pop(context)}
                    ),
                  ],
                )),
          );
        }); 
     }
  
  
     
    
    dipose(){
      _keyBoardController.close();
      _toggleSpinnerController.close();
    }
}