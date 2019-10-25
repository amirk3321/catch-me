import 'package:catch_me/model/chat_channel.dart';
import 'package:catch_me/model/chat_channel_entity.dart';
import 'package:catch_me/model/friends.dart';
import 'package:catch_me/model/text_message.dart';
import 'package:catch_me/model/text_message_entity.dart';
import 'package:catch_me/model/user.dart';
import 'package:catch_me/model/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'repo_base.dart';

class FirebaseUserRepository implements BaseRepo {
  FirebaseAuth _firebaseAuth;
  final _userCollection = Firestore.instance.collection('user');
  final _chatChannel = Firestore.instance.collection('chatChannel');
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
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Stream<List<User>> users() {
    return _userCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => User.fromEntity(UserEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> getInitializedCurrentUser({String name}) async {
    _userCollection
        .document((await _firebaseAuth.currentUser()).uid)
        .get()
        .then((user) async {
      if (!user.exists) {
        final newUser = User(
                name: name,
                status: "Hi there i am using this app.",
                uid: (await _firebaseAuth.currentUser()).uid,
                isLocation: false)
            .toEntity()
            .toDocument();

        _userCollection
            .document((await _firebaseAuth.currentUser()).uid)
            .setData(newUser);
      }
    }).catchError((e) => print('getInitializedCurrentUser :${e.toString()}'));
  }

  @override
  Future<void> onUpdateUserInfo(
      {String name,
      String status,
      String profileUrl,
      String uid,
      String channelId,
      bool isLocation,
      bool isOnline}) async {
    Map<String, Object> updateUser = Map();
    print("checkLocation $isLocation CheckUID $uid");
    if (name.isNotEmpty) updateUser['name'] = name;
    if (status.isNotEmpty) updateUser['status'] = status;
    if (profileUrl != null) updateUser['profileUrl'] = profileUrl;

    if (isLocation == true)
      updateUser['isLocation'] = false;
    else
      updateUser['isLocation'] = true;

    if (isOnline == false)
      updateUser['isOnline'] = isOnline;
    else
      updateUser['isOnline'] = isOnline;

    _userCollection.document(uid).updateData(updateUser);
  }

  Future<void> onUpdateUserInfo1(
      {String name, String uid, bool isLocation}) async {
    Map<String, Object> updateUser = Map();

    if (name.isNotEmpty) updateUser['name'] = name;
    if (isLocation == false)
      updateUser['isLocation'] = isLocation;
    else
      updateUser['isLocation'] = isLocation;

    _userCollection.document(uid).updateData(updateUser);
  }

  //chat channel
  @override
  Future<void> getCreateChatChannel(
      {String otherUID, Function onComplete}) async {
    _userCollection
        .document((await _firebaseAuth.currentUser()).uid)
        .collection("engagedChatChannels")
        .document(otherUID)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        onComplete(snapshot.data['channelId']);
        return;
      }

      var newChatChannel = _chatChannel.document();

      newChatChannel.setData(ChatChannel(
              channelId: newChatChannel.documentID,
              userIds: [(await _firebaseAuth.currentUser()).uid, otherUID])
          .toEntity()
          .toDocument());

      var channel = {'channelId': newChatChannel.documentID};

      _userCollection
          .document((await _firebaseAuth.currentUser()).uid)
          .collection("engagedChatChannels")
          .document(otherUID)
          .setData(channel);

      Firestore.instance
          .collection("user")
          .document(otherUID)
          .collection("engagedChatChannels")
          .document((await _firebaseAuth.currentUser()).uid)
          .setData(channel);

      onComplete(newChatChannel.documentID);
      return;
    });
  }

  Future<void> sendTextMessage({String channelId, TextMessage message}) async {
    _chatChannel
        .document(channelId)
        .collection("messages")
        .document()
        .setData(message.toEntity().toDocument());
  }

  //get All text messages
  Stream<List<TextMessage>> messages({String channelId}) {
    return _chatChannel
        .document(channelId)
        .collection("messages")
        .orderBy('time')
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((snapshotDocument) => TextMessage.fromEntity(
              TextMessageEntity.fromSnapshot(snapshotDocument)))
          .toList();
    });
  }

  Stream<List<ChatChannel>> generatedChannelIds() {
    return _chatChannel.snapshots().map((snapshot) {
      return snapshot.documents
          .map((snapshotChannelIds) => ChatChannel.fromEntity(
              ChatChannelEntity.fromSnapshot(snapshotChannelIds)))
          .toList();
    });
  }

  //add to chat screen
  Future<void> addToStartChat({Friends friends}) async {
    _userCollection
        .document((await _firebaseAuth.currentUser()).uid)
        .collection("friends")
        .document(friends.otherUID)
        .get()
        .then((friend) async {
      if (!friend.exists) {
        _userCollection
            .document((await _firebaseAuth.currentUser()).uid)
            .collection("friends")
            .document(friends.otherUID)
            .setData(Friends(
          name: friends.name,
          channelId:friends.channelId,
          otherUID: friends.otherUID,
          uid: friends.uid,
          profileUrl: friends.profileUrl,
          unRead: friends.unRead,
        ).toEntity().toDocument());
      }
    });
  }
}
