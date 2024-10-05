import 'dart:developer';

import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No message found'));
        }

        final List<QueryDocumentSnapshot<Map<String, dynamic>>> messages =
            snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.all(8),
          reverse: true,
          itemBuilder: (context, index) {
            final currentUserId = messages[index].data()['userId'];
            final nextUserId = index + 1 >= messages.length
                ? null
                : messages[index + 1].data()['userId'];

            if (currentUserId != nextUserId) {
              return MessageBubble.first(
                  userName: messages[index].data()['userName'],
                  imageUrl: messages[index].data()['userImage'],
                  isMe: user!.uid == messages[index].data()['userId'],
                  message: messages[index].data()['message']);
              /*   return MessageBubble.first(
                  userImage: messages[index].data()['userImage'],
                  username: messages[index].data()['userName'],
                  message: messages[index].data()['message'],
                  isMe: user!.uid == messages[index].data()['userId']);*/
            } else {
              return MessageBubble.next(
                  isMe: user!.uid == messages[index].data()['userId'],
                  message: messages[index].data()['message']);
              /*  return MessageBubble.next(
                  message: messages[index].data()['message'],
                  isMe: user!.uid == messages[index].data()['userId']);*/
            }
          },
          itemCount: messages.length,
        );
      },
    );
  }
}
