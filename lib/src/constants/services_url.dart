import 'package:flutter/material.dart';
class UrlServices extends InheritedWidget {
  static UrlServices of(BuildContext context) => context. dependOnInheritedWidgetOfExactType<UrlServices>();

   UrlServices({Widget child, Key key}): super(key: key, child: child);


  final String base_url ="192.168.5.118:9090";
 
  final dynamic autentication ={
    'singIn':'/login/all',   
  };

   final dynamic tramites ={
    'getAll':'/tramite/all',
    'changeTramiteStatus':'/tramite/status'
  };

  @override
  bool updateShouldNotify(UrlServices oldWidget) => false;
    /* UrlServices(); */
}