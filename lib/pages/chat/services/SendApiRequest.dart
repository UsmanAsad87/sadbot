
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Map<String, String>  _mainHeaders = {
  'Content-type' : 'application/json',
  'Api-Version': 'v1',
  'Accept': 'application/json',
};
Future<Map<String, dynamic>> askQuestion({
  required String question,
  required String ip,
  required String port,
})async{
  Map<String, dynamic> body = {
    "question": question,
  };
  String url = 'http://$ip:$port/ask_bot';
  try{
    var response = await http.post(
      Uri.parse(url),
      body: json.encode(body),
      headers: _mainHeaders,
    );

    if (kDebugMode) {
      print(response.statusCode);
    }

    if (response.statusCode == 200) {
      final msg = jsonDecode(response.body);
      print(msg);
      return msg;

      // if (msg['success'] == true) {
      //   print('face_found');
      //   //showToast("Face is in database. Entry is added");
      //   return msg;
      // } else {
      //   final msg = jsonDecode(response.body);
      //   print('Face not found');
      //   //showToast("Face is added in database. Entry is added");
      //   return false;
      // }
    }  else {
      final msg = jsonDecode(response.body);
      return msg;
    }
  }catch(e){
    print(e.toString());
    return {'success':false};
  }

}