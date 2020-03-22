import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/widgets/appCurvedShape.dart';
import 'package:flutter_chat/src/widgets/appRoundCard.dart';
import 'package:flutter_chat/src/widgets/appRoundIcon.dart';
import 'package:flutter_chat/src/widgets/appTitle.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chat/src/models/profile_model.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  ProfileModel profileModel;
  String nombre="";
  @override
  _HomeScreenState createState() => _HomeScreenState();
    HomeScreen({ this.profileModel, this.nombre});
}
 

class _HomeScreenState extends State<HomeScreen> {
  void changeActualScreen(Bloc bloc, int actualScreen){ 
      bloc.containerScreens.changeActualScreen(actualScreen); 
  }

  Widget appTitleData(String nombreTemp){
    return  AppTitle(
                    inputText:  "Bienvendio a Aduanas",
                    secondText: "¿Qué trámites realizaremos hoy?",
                     withAppBar: true,
                   );
  }
  
  @override
  Widget build(BuildContext context) {
  
    void initProfile(Bloc bloc) async{
      ProfileModel p = await bloc.login.addProfileData();
      widget.profileModel = p;     
      widget.nombre=widget.profileModel.getNombre;
      bloc.containerScreens.changeHomeScreen(true);      
    }

    WidgetsFlutterBinding.ensureInitialized();
    final bloc = Provider.of<Bloc>(context);  
    initProfile(bloc);
    return  StreamBuilder(
    stream: bloc.containerScreens.getHomeScreenTrasnformer, 
    builder: (context, snapshoot){
      return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: <Widget>[
                CurvedShape(),
                appTitleData(widget.nombre),
                SizedBox(height: 25.0,),
                AppRoundIcon(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 44.0),
                    height: MediaQuery.of(context).size.height/0.5,
              /*       child: Center( */
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 2.88,
                          ),
                          GridView.count(
                            primary: false,                            
                            padding: const EdgeInsets.fromLTRB(1, 10, 1, 10),
                            crossAxisCount: 2,
                            childAspectRatio: 0.80,
                            mainAxisSpacing: 0.2,
                            crossAxisSpacing: 1.0,
                            children: <Widget>[
                              AppRoundCard(
                                  onClick:()=> changeActualScreen(bloc, 1),
                                  inputText: "Tramites",
                                  iconCard: Icons.description,
                                  inputColor:Theme.of(context).accentColor),
                              AppRoundCard(
                                  onClick:()=> changeActualScreen(bloc, 2),
                                  inputText: "Aforos",
                                  iconCard: Icons.group,
                                  inputColor:Theme.of(context).accentColor),
                              AppRoundCard(
                                  onClick:()=> changeActualScreen(bloc,3),
                                  inputText: "Archivos",
                                  iconCard: Icons.folder_special,
                                  inputColor:Theme.of(context).accentColor),
                              AppRoundCard(
                                  onClick:()=> changeActualScreen(bloc, 4),
                                  inputText: "Reporteria",
                                  iconCard: Icons.pie_chart,
                                  inputColor: Theme.of(context).accentColor),
                            ],
                            shrinkWrap: true,
                          )
                        ],
                      ),
                   ),
              ],
            )
          );
   
    });
      
  }
}
