

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{

  static const _USER_CURRENT_UID="com.c4coding.USER_CURRENT_ID";
  static const _USER_CHAT_CHANNEL_ID="com.c4coding.USER_CHAT_CHANNEL_ID";

  static Future<String> getCurrentUID() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString(_USER_CURRENT_UID);
  }
  static Future<String> getChatChannelID() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.getString(_USER_CHAT_CHANNEL_ID);
  }

  static Future<void> setCurrentUID({String uid}) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString(_USER_CURRENT_UID,uid);
  }

  static Future<void> setChatChannelID({String channelId}) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString(_USER_CHAT_CHANNEL_ID,channelId);
  }
}