// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/chat_card.dart';
import 'package:full_stack_whatsapp_flutter/model/chat_model.dart';
import 'package:full_stack_whatsapp_flutter/screens/select_contact.dart';

class Chats extends StatefulWidget {
  const Chats({super.key, required this.chats, required this.sourceChat});
  final List<ChatModel> chats;
  final ChatModel sourceChat;


  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 19, 149, 134),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => SelectContacct()));
        },
        child: const Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.chats.length,
        itemBuilder: (context, index) {
          return ChatCard(
            chatmodel:  widget.chats[index],
            sourceChat:widget.sourceChat
          );
        },
      ),
    );
  }
}
