import 'package:flutter/material.dart';
import 'package:flutter_chat/src/bloc/bloc.dart';
import 'package:flutter_chat/src/screens/aforos_screen.dart';
import 'package:flutter_chat/src/screens/home_screen.dart';
import 'package:flutter_chat/src/screens/qrscanner_screen.dart';
import 'package:flutter_chat/src/screens/tramites_screen.dart';
import 'package:provider/provider.dart';

class ContainerHome extends StatefulWidget {
  static const String routeName = "/containerHome";
  ContainerHome({Key key}) : super(key: key);

  @override
  _ContainerHomeState createState() => _ContainerHomeState();
}

class _ContainerHomeState extends State<ContainerHome> {
  @override

  @override
  Widget build(BuildContext context) {
   final bloc = Provider.of<Bloc>(context);
   bloc.containerScreens.changeActualScreen(0);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0), // here the desired height
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Color.fromRGBO(255, 143, 52, 1),
            elevation: 0.0,
          )),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: getDrawer(bloc)),
      
           body: StreamBuilder(
          stream: bloc.containerScreens.getActualScreen,
          builder: (context, snapshot) {
            return getWidgetActualScreen(bloc, snapshot);
          })!=null ?  StreamBuilder(
          stream: bloc.containerScreens.getActualScreen,
          builder: (context, snapshot) {
            return getWidgetActualScreen(bloc, snapshot);
          }) :  AforosScreen() 
    );
  }
  Widget getWidgetActualScreen(Bloc bloc, AsyncSnapshot<dynamic> snapshot){
    print("bloc.getDataActualSceen();");
    print(snapshot.data);
     return snapshot.data;
  }
  Drawer getDrawer(Bloc bloc) {
    return Drawer(
      child: getListDrawer(bloc),
    );
  }

  ListTile getItem(Icon icon, String description, String route, int actualScreen, Bloc bloc) {
    return ListTile(
      leading: icon,
      title: Text(
        description,
        style: TextStyle(color: Color.fromRGBO(142, 144, 146, 1)),
      ),
      onTap: () {
        Navigator.pop(context);
        bloc.containerScreens.changeActualScreen(actualScreen);
      },
    );
  }

  ListTile getItemAccion(Icon icon, String description) {
    return ListTile(
      leading: icon,
      title: Text(
        description,
        style: TextStyle(color: Color.fromRGBO(142, 144, 146, 1)),
      ),
    );
  }

  ListView getListDrawer(Bloc bloc) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            "Mauricio Muñoz",
            style: TextStyle(color: Colors.white),
          ),
          accountEmail: Text(
            "mauriciomuñoz@hotmail.com",
            style: TextStyle(color: Colors.white),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              "M M",
              style: TextStyle(color: Color.fromRGBO(142, 144, 146, 1)),
            ),
          ),
        ),
        getItem(Icon(Icons.home), "Inicio", "/home", 0, bloc),
        getItem(Icon(Icons.description), "Tramites", "/tramites", 1, bloc),
        getItem(Icon(Icons.group), "Aforos", "/aforos", 2, bloc),
        getItem(Icon(Icons.folder_special), "Archivo", "/archivos", 3, bloc),
        getItem(Icon(Icons.pie_chart), "Reporteria", "/reportes", 4, bloc),
        SizedBox(
          height: 20.0,
        ),
        Divider(),
        getItemAccion(Icon(Icons.refresh), "Actualizar"),
        AboutListTile(
          child: Text(
            "Más Información",
            style: TextStyle(color: Color.fromRGBO(142, 144, 146, 1)),
          ),
          applicationVersion: "1.1.0",
          applicationIcon: Icon(Icons.info),
          icon: Icon(Icons.info),
        ),
        getItemAccion(Icon(Icons.exit_to_app), "Salir"),
      ],
    );
  }
}
