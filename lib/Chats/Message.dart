import 'package:chating_app/Chats/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   StreamBuilder(stream: FirebaseFirestore.instance.collection('chat').orderBy("createAt", descending: true).snapshots(), builder:(ctx,AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              final chatDocs = snapshot.data.docs;
              final User auth = FirebaseAuth.instance.currentUser as User;
                  return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data.docs.length,itemBuilder: (ctx, index)=>MessageBubble(message: chatDocs[index]['text'] ?? 0,userName: chatDocs[index]['username']  , isMe: chatDocs[index]['userId']  == auth.uid,userImage: chatDocs[index]['userImage']));
              
        });
  }
}