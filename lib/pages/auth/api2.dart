import 'dart:convert';
import 'package:http/http.dart' as http;

class YourClass2 {
  String cookie = '34234242423'; // Set your initial cookie value here

  Future<Map<String, dynamic>> initConversation() async {
    Map<String, String> headers = {
      'method': 'POST',
      'accept': 'application/json',
      'x-api-version': '2',
      'referer': 'https://heypi.com/talk',
      'content-type': 'application/json',
    };

    if (cookie.isNotEmpty) {
      headers['cookie'] = '__Host-session=$cookie';
    }

    Map<String, dynamic> data = {};

    http.Response response = await http.post(
      Uri.parse('https://heypi.com/api/chat/start'),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      String responseData = response.body;
      Map<String, dynamic> dataJson = jsonDecode(responseData);

      if (!dataJson.containsKey('latestMessage') || dataJson['latestMessage'].isEmpty) {
        throw Exception('Failed to init conversation');
      }

      String? newCookie = response.headers['set-cookie'];
      if (newCookie != null) {
        int startIndex = newCookie.indexOf('__Host-session=') + '__Host-session='.length;
        int endIndex = newCookie.indexOf(';', startIndex);
        cookie = newCookie.substring(startIndex, endIndex);
      }

      return {
        'cookie': cookie,
      };
    } else {
      // Handle error
      print('HTTP Error: ${response.statusCode}');
      throw Exception('Failed to init conversation');
    }
  }
}
