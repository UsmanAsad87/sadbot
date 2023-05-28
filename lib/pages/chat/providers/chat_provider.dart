import 'package:flutter/material.dart';
import 'package:group_chat_app/pages/chat/models/chat_model.dart';

import '../services/ApiService.dart';

class ChatProvider with ChangeNotifier{
  List<ChatModel> chatList=[];
  List<ChatModel> get getChatList{
    return chatList;
  }
  
  void addUserMessage({required String msg}){
    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    notifyListeners();
  }
  
  Future<void> sendMessageAndGetAns({required String msg}) async{
    chatList.addAll(await ApiService.sendMessage(
      message: msg,
    ));
    notifyListeners();
  }

  void clearChatList(){
    print("clearing");
    chatList=[];
    notifyListeners();
  }
}