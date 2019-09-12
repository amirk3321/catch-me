
abstract class BaseRepo{
  Future<bool> isSignIn();
  Future<void> onPhoneAuthentication({String phoneNumber});
  Future<void> onSignInWithPhoneNumber({String smsCode});
  Future<String> getCurrentUID();
}