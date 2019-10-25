
import 'package:catch_me/model/user.dart';

abstract class BaseRepo{
  Future<bool> isSignIn();
  Future<void> onPhoneAuthentication({String phoneNumber});
  Future<void> onSignInWithPhoneNumber({String smsCode});
  Future<String> getCurrentUID();
  Stream<List<User>> users();
  Future<void> getInitializedCurrentUser();
  Future<void> onUpdateUserInfo(
      {String name, String status, String profileUrl, String uid,String channelId,bool isLocation,bool isOnline});
  Future<void> getCreateChatChannel({String otherUID,Function onComplete});
  //Future<void> sendFriendRequest({String otherUID, Patient patient})
}