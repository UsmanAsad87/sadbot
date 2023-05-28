import 'package:flutter/material.dart';
import 'package:group_chat_app/pages/auth/login_page.dart';
import 'package:group_chat_app/pages/chat/constants/constants.dart';
import 'package:group_chat_app/service/auth_service.dart';
import 'package:provider/provider.dart';

import '../providers/chat_provider.dart';

class Services {
  static Future<void> showModalSheet(BuildContext context) async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: scaffoldBackgroundColor,
        context: context,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 18.0),
                child: InkWell(
                  onTap: () {
                    final chatProv =
                        Provider.of<ChatProvider>(context, listen: false);
                    chatProv.clearChatList();
                  },
                  child: const Text(
                    "Clear History",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Logout",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),),
                          content: const Text("Are you sure you want to logout?"),
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await  AuthService().signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const LoginPage()),
                                        (route) => false);
                              },
                              icon: const Icon(
                                Icons.done,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        );
                      });
                },
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                leading: const Icon(Icons.exit_to_app,color: Colors.white,),
                title: const Text(
                  "Logout",
                  style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500),
                ),
              )
            ],
          );
        });
  }
}
