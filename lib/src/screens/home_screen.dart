import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/widgets/appButton.dart';
import 'package:flutter_chat/src/widgets/appCurvedShape.dart';
import 'package:flutter_chat/src/widgets/appRoundCard.dart';
import 'package:flutter_chat/src/widgets/appRoundIcon.dart';
import 'package:flutter_chat/src/widgets/appTextField.dart';
import 'package:flutter_chat/src/widgets/appTitle.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void changeActualScreen(Bloc bloc, int actualScreen){
    print("medoto widget active-------------"); 
      bloc.containerScreens.changeActualScreen(actualScreen);
       
      
  }
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<Bloc>(context);
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                CurvedShape(),
                AppTitle(
                    inputText: "Bienvenido Diego!",
                    secondText: "¿Qué trámites haremos hoy?"),
                AppRoundIcon(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 44.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.88,
                          ),
                          GridView.count(
                            primary: false,
                            padding: const EdgeInsets.all(1),
                            crossAxisCount: 2,
                            childAspectRatio: 0.80,
                            mainAxisSpacing: 1.0,
                            crossAxisSpacing: 1.0,
                            children: <Widget>[
                              AppRoundCard(
                                  onClick:()=> changeActualScreen(bloc, 1),
                                  inputText: "Tramites",
                                  iconCard: Icons.description,
                                  inputColor: Color.fromRGBO(142, 144, 146, 1)),
                              AppRoundCard(
                                  onClick:()=> changeActualScreen(bloc, 2),
                                  inputText: "Aforos",
                                  iconCard: Icons.group,
                                  inputColor: Color.fromRGBO(142, 144, 146, 1)),
                              AppRoundCard(
                                  onClick:()=> changeActualScreen(bloc,3),
                                  inputText: "Archivos",
                                  iconCard: Icons.folder_special,
                                  inputColor: Color.fromRGBO(142, 144, 146, 1)),
                              AppRoundCard(
                                  onClick:()=> changeActualScreen(bloc, 4),
                                  inputText: "Reporteria",
                                  iconCard: Icons.pie_chart,
                                  inputColor: Color.fromRGBO(142, 144, 146, 1)),
                            ],
                            shrinkWrap: true,
                          )
                        ],
                      ),
                    )),
              ],
            ))
      ],
    );
  }
}
