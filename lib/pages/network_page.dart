import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:group_chat_app/helper/helper_function.dart';
import 'package:group_chat_app/pages/auth/register_page.dart';
import 'package:group_chat_app/pages/chat/screens/chat_screen.dart';
import 'package:group_chat_app/pages/home_page.dart';
import 'package:group_chat_app/service/auth_service.dart';
import 'package:group_chat_app/service/database_service.dart';
import 'package:group_chat_app/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({Key? key}) : super(key: key);

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  final formKey = GlobalKey<FormState>();
  String ipAddress = "";
  String portNo = "";
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // const Text(
                        //   "ChatBOT",
                        //   style: TextStyle(
                        //       fontSize: 40, fontWeight: FontWeight.bold),
                        // ),
                        // const SizedBox(height: 10),
                        // const Text("Awareness for Mental Illness",
                        //     style: TextStyle(
                        //         fontSize: 15, fontWeight: FontWeight.w400)),
                        Image.asset("assets/SAD_BOT.png"),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "IP address",
                              prefixIcon: Icon(
                                Icons.computer,
                                color: Theme.of(context).primaryColor,
                              )),
                          onChanged: (val) {
                            setState(() {
                              ipAddress = val;
                            });
                          },

                          // check tha validation
                          validator: (val) {
                            if (val!.length < 9) {
                              return "Invalid Format";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          // obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              labelText: "Port No.",
                              prefixIcon: Icon(
                                Icons.numbers,
                                color: Theme.of(context).primaryColor,
                              )),
                          validator: (val) {
                            if (val!.length < 2) {
                              return "Invalid Format";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              portNo = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text(
                              "Continue",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            onPressed: () {
                              saveData();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
              ),
            ),
    );
  }

  saveData() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('ip_address', ipAddress);
        await prefs.setString('port_no', portNo);

        nextScreenReplace(context, const ChatScreen());
      setState(() {
        _isLoading = false;
      });
    }
  }
}
