class UrlServices { 
 
  final dynamic autentication ={
    'singIn':'login/authorization',    
    'getPhoneData': 'login/registerSessionTokenFCM',
    'sendEmail': 'login/validaCorreoRecordarContrasenia',
    'validateCode': 'login/validacionTokenRecordarContrasenia',
    'changePassword':'login/validarCambioContrasenia'    
  };

   final dynamic tramites ={
    'getAll':'tramite/all',
    'changeTramiteStatus':'tramite/status'
  };

} 