import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aduanas_app/src/bloc/bloc.dart';
import 'package:aduanas_app/src/models/profile_model.dart';
/* import 'package:aduanas_app/src/repositories/repository.dart'; */
import 'package:aduanas_app/src/screens/aforos_screen.dart';
import 'package:aduanas_app/src/widgets/appSpinner.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ContainerHome extends StatefulWidget {

  static const String routeName = "/containerHome";
   String token;
     String nombre="";
    final storage = new FlutterSecureStorage();
     ProfileModel profileModel;
   void logOut(Bloc bloc, BuildContext context){
      bloc.login.logOut(context);
   }
        ContainerHome({this.token, this.profileModel});

  @override
  _ContainerHomeState createState() => _ContainerHomeState();
}

class _ContainerHomeState extends State<ContainerHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
/*  final Repository repository = new Repository(); */
  @override

  Widget build(BuildContext context) {
 
    void iniToken(BuildContext context, Bloc bloc)async{
    widget.token=await  widget.storage.read(key: 'jwt') ;
    if(widget.token==null ||  widget.token=="" ){
        Navigator.pushNamed(context, "/login");
    }
    else{   
    //   bloc.initLoginScreen();
       ProfileModel p = await bloc.login.addProfileData();        
       widget.profileModel = p;   
    }    

  }
  Future<bool> navigationBack(Bloc bloc, BuildContext context){
      //  Navigator.pop(context, true);
       if(bloc.containerScreens.getDataActualScreen()==0){
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
        else if(bloc.containerScreens.getDataActualScreen()==5){       
          bloc.containerScreens.changeActualScreen(1);
        }
        else{
          Navigator.pushNamed(context, "/containerHome");
          bloc.containerScreens.changeActualScreen(0);
        }
  }

  WidgetsFlutterBinding.ensureInitialized();
   final bloc = Provider.of<Bloc>(context);      
   iniToken(context, bloc);    
      if(bloc.containerScreens.getDataActualScreen()!=0){
        bloc.containerScreens.changeActualScreen(0);    
     }
   
    return WillPopScope(
      onWillPop: () => navigationBack(bloc, context),
 
      child:Stack(
      children: <Widget>[           
         Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0), // here the desired height
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Theme.of(context).primaryColor,
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
    ),
     SpinnerLoading(streamDataTransform: bloc.utilsBloc.getSpinnerState),       
      ],
    )
    ); 
 }
  Widget getWidgetActualScreen(Bloc bloc, AsyncSnapshot<dynamic> snapshot){   
     return snapshot.data;
  }
  StreamBuilder getDrawer(Bloc bloc) {
    return  StreamBuilder(
          stream: bloc.containerScreens.getDrawerTrasnformer,
          builder: (context, snapshot) {
            return Drawer(
                  child: getListDrawer(bloc),
                );
          });
    
    
  }

  ListTile getItem(Icon icon, String description, String route, int actualScreen, Bloc bloc) {
    return ListTile(
      leading: icon,
      title: Text(
        description,
        style: TextStyle(color: Theme.of(context).accentColor),
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
        style: TextStyle(color: Theme.of(context).accentColor),
      ),
    );
  }

  ListView getListDrawer(Bloc bloc) {
    var initials = widget.profileModel.getNombre!=null?widget.profileModel.getNombre.substring(0,1).toUpperCase() + " " +widget.profileModel.getNombre.substring(1,2).toUpperCase() :"" ;
     
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            widget.profileModel.getNombre ,
            style: TextStyle(color: Colors.white),
          ),
          accountEmail: Text(
            widget.profileModel.getCorreo
          /*  bloc.login.getProfile().getCorreo!=null?bloc.login.getProfile().getCorreo: */,
            style: TextStyle(color: Colors.white),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
               initials,
              style: TextStyle(color: Theme.of(context).accentColor),
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
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          applicationVersion: "1.1.0",
          applicationIcon: Icon(Icons.info),
          icon: Icon(Icons.info),
        ),
        GestureDetector(
          onTap: () => widget.logOut( bloc,  context),
          child:   getItemAccion(Icon(Icons.exit_to_app), "Salir"),
        ),      
      ],
    );
  }
}
