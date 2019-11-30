
import 'package:permission_handler/permission_handler.dart';

class PermissionService{
  final PermissionHandler _permissionHandler=PermissionHandler();

  Future<bool> _permissionGroup({PermissionGroup permissions})async{
    var result=await _permissionHandler.requestPermissions([permissions]);
    if (result[permissions] == PermissionStatus.granted)
      return true;
    return false;
  }
  Future<bool> requestMicroPhonePermission()async{
    return _permissionGroup(permissions: PermissionGroup.microphone);
  }
  Future<bool> requestLocationPermission()async{
    return _permissionGroup(permissions: PermissionGroup.location);
  }

}