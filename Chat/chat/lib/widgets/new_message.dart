import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final messageController = TextEditingController();
  String? newMessage;
  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  sendMessage() async {
    FocusScope.of(context).unfocus();

    messageController.clear();
    final User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot<Map<String, dynamic>> userData =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();
    
    await FirebaseFirestore.instance.collection('chat').add({
      'userId': user.uid,
      'time': Timestamp.now(),
      'message': newMessage,
      'userName': userData.data()!['username'],
      'userImage': userData.data()!['imageUrl'],
    });
    setState(() {
      newMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    //newMessage=messageController.text;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
              onChanged: (value) {
                setState(() {
                  newMessage = value;
                });
              },
              controller: messageController,
              decoration: const InputDecoration(hintText: 'Enter message'),
            ),
          ),
          if (newMessage == null)
            const IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.send,
                )),
          if (newMessage != null)
            IconButton(
                onPressed: sendMessage,
                icon: Icon(Icons.send,
                    color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}
