import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enterMessage = '';
  final _controller = new TextEditingController();
  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enterMessage,
      'createAt' : Timestamp.now(),
      'userId' : user.uid,
      'username': userData['username'],
      'userImage': userData['image_url']
    });
    _controller.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
       child:Row(children: [
           Expanded(child: TextField(
             controller: _controller,
             decoration: InputDecoration(labelText: "send a Message..."),
           onChanged: (value){
             setState(() {
               _enterMessage = value;
             });
           })),
           IconButton(onPressed: _enterMessage.trim().isEmpty ? null : _sendMessage, icon:const Icon(Icons.send), color: Theme.of(context).primaryColor)
       ]));
  }
}