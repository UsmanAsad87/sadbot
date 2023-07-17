import 'dart:convert';
import 'package:http/http.dart' as http;

typedef CallbackFunction = void Function(String currentText, String tokens);

class Event {
  String data;
  Event(this.data);
}

class EventSource {
  String url;
  CallbackFunction? onMessage;

  EventSource(this.url);

  void setCurlOptions(Map<String, dynamic> options) {
    // Set Curl options if required
  }

  void connect() async {
    // Connect to the EventSource URL
    // Implementation depends on your specific requirements
  }
}

class Prompt {
  String text;
  Prompt(this.text);
}

class YourClass {
  String currentText = '';
  bool ended = false;
  String cookie = ''; // Set your cookie value here

  Future<String> ask(Prompt message, [CallbackFunction? callback]) async {
    currentText = '';

    EventSource es = EventSource("https://heypi.com/api/chat");

    Map<String, String> headers = {
      'method': 'POST',
      'accept': 'text/event-stream',
      'Accept-Encoding': 'gzip, deflate, br',
      'referer': 'https://heypi.com/talk',
      'content-type': 'application/json',
      // 'cookie': '__Host-session=$cookie',
    };

    Map<String, String> data = {
      'text': message.text,
    };

    http.Response response = await http.post(
      Uri.parse(es.url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      String eventData = response.body;
      Map<String, dynamic> message = handlePacket(eventData);

      if (message == false || message['text'].isEmpty) return currentText;

      String tokens = message['text'].substring(currentText.length);
      currentText = message['text'];

      if (callback != null) {
        callback(currentText, tokens);
      }
    } else {
      // Handle error
      print('HTTP Error: ${response.statusCode}');
    }

    // Handle abort
    if (currentText.isEmpty) {
      ended = true;
      currentText = "I'm sorry, please start a new conversation!";

      if (callback != null) {
        callback(currentText, currentText);
      }
    }

    return currentText;
  }

  Map<String, dynamic> handlePacket(String eventData) {
    // Implement the handlePacket function according to your requirements
    // It should return a map of the message data
    return jsonDecode(eventData);
  }
}
