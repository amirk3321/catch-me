import 'package:firebase_auth/firebase_auth.dart';

import 'repo_base.dart';

class FirebaseUserRepository implements BaseRepo {
  FirebaseAuth _firebaseAuth;
  String verificationId;

  FirebaseUserRepository({FirebaseUserRepository firebaseUserRepository})
      : _firebaseAuth = firebaseUserRepository ?? FirebaseAuth.instance;

  @override
  Future<bool> isSignIn() async {
    return (await _firebaseAuth.currentUser()).uid != null;
  }

  @override
  Future<void> onPhoneAuthentication({String phoneNumber}) async {
    final PhoneVerificationCompleted verificationComleted =
        (AuthCredential authCredential) {
      print('phone is verified');
    };

    final PhoneVerificationFailed phoneVerificationFailed = (AuthException e) {
      print('${e.message.toString()}');
    };

    final PhoneCodeSent phoneCodeSent =
        (String verificationID, [int forceResendingToken]) {
      this.verificationId = verificationID;
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationId = verificationId;
      print('time out');
    };

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verificationComleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }

  @override
  Future<void> onSignInWithPhoneNumber({String smsCode}) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: this.verificationId, smsCode: smsCode);
    await _firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<String> getCurrentUID() async{
   return (await _firebaseAuth.currentUser()).uid;
  }

  Future<void> signIn(String email,String password)async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

}
