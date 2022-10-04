import 'package:chating_app/Chats/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Chats/Message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  @override
  void initState() {
    // TODO: implement initState
    final fms = FirebaseMessaging.onMessage.listen((event) {
      print(event);
      return;
    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(body: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: Text("Flutter chat"), actions: [
                DropdownButton(
                    icon: Icon(Icons.more_vert,
                        color: Colors.white),
                    items: [
                      DropdownMenuItem(
                        child: Container(
                            child: Row(children: [
                          Icon(Icons.exit_to_app),
                          SizedBox(width: 8),
                          Text('Logout')
                        ])),
                        value: "Logout",
                      ),
                    ],
                    onChanged: (itemIdentifier) {
                      if (itemIdentifier == 'Logout') {
                        FirebaseAuth.instance.signOut();
                      }
                    })
              ]),
              body: Container(
                child: Column(children: [
                  Expanded(child: Message()),
                  NewMessage()
                ]),
              ),
            );
          }
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }
}
