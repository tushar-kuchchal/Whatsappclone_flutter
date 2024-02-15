// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/chat_card.dart';
import 'package:full_stack_whatsapp_flutter/model/chat_model.dart';
import 'package:full_stack_whatsapp_flutter/screens/select_contact.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

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
    List<ChatModel> chats = [
      ChatModel(
          name: 'Tushar Kuchchal',
          icon: 'personIcon.svg',
          isGroup: false,
          time: '9:10 am',
          currentMessage: 'Hello tushar, how are you?'),
      ChatModel(
          name: 'Vishal Kuchchal kuchchal',
          icon: 'personIcon.svg',
          isGroup: false,
          time: '12:10 am',
          currentMessage: 'Hello vishal , Please send me your email id'),
      ChatModel(
          name: 'Modi Sarkar',
          icon: 'groupIcon.svg',
          isGroup: true,
          time: '9:10 am',
          currentMessage: 'What is the poll in gujrat'),
      ChatModel(
          name: 'Harsh Jain',
          icon: 'personIcon.svg',
          isGroup: false,
          time: '9:10 am',
          currentMessage:
              'hi Harsh jain, we will go tonight for dinner, are you ok with that'),
    ];
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
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return ChatCard(
            chatmodel: chats[index],
          );
        },
      ),
    );
  }
}
