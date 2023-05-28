import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:group_chat_app/pages/chat/models/chat_model.dart';
import 'package:group_chat_app/pages/chat/services/SendApiRequest.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

  //Send Message to model
  static Future<List<ChatModel>> sendMessage(
      {required String message}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String ipAddress = prefs.getString('ip_address') ?? '';
      String portNo = prefs.getString('port_no') ?? '';

      Map<String, dynamic> jsonResponse = await askQuestion(question: message, ip: ipAddress, port: portNo);

      if (jsonResponse['success'] != true) {
        throw HttpException("Some error occurred");
      }
      List<ChatModel> chatList = [];
      chatList = List.generate(
        1,
        (index) => ChatModel(
          msg: jsonResponse['ans'],
          chatIndex: 1,
        ),
      );

      return chatList;
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }
}
