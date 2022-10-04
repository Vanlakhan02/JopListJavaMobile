import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final bool isMe;
  final String userImage;
  const MessageBubble(
      {required this.message,
      required this.isMe,
      required this.userName,
      required this.userImage,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    color:
                        isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft:
                            !isMe ? Radius.circular(0) : Radius.circular(12),
                        bottomRight:
                            isMe ? Radius.circular(0) : Radius.circular(12))),
                width: 140,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(message,
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                        style: TextStyle(
                            color: isMe
                                ? Colors.black
                                : Theme.of(context)
                                    .accentTextTheme
                                    .headline1!
                                    .color)),
                  ],
                )),
          ],
        ),
        Positioned(
          top: -10,
          left:isMe? null : 120,
          right: isMe? 120 : null,
          child: CircleAvatar(backgroundImage: NetworkImage(userImage),),
        )
      ],
    );
  }
}
