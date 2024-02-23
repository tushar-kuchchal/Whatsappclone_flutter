import 'package:flutter/material.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/button_card.dart';
import 'package:full_stack_whatsapp_flutter/screens/home.dart';

import '../model/chat_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;
  List<ChatModel> chats = [
    ChatModel(
        name: 'Tushar Kuchchal',
        icon: 'personIcon.svg',
        isGroup: false,
        time: '9:10 am',
        id: 1,
        currentMessage: 'Hello tushar, how are you?'),
    ChatModel(
        name: 'Vishal Kuchchal',
        icon: 'personIcon.svg',
        isGroup: false,
        time: '12:10 am',
        id: 2,
        currentMessage: 'Hello vishal , Please send me your email id'),
    ChatModel(
        name: 'Harsh Jain',
        icon: 'personIcon.svg',
        isGroup: false,
        time: '9:10 am',
        id: 3,
        currentMessage:
            'hi Harsh jain, we will go tonight for dinner, are you ok with that'),
  ];

  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            return ButtonCard(
                icon: Icons.person,
                name: chats[index].name,
                onTap: () {
                  sourceChat = chats.removeAt(index);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Home(
                                chats: chats,
                                sourceChat:sourceChat
                              )));
                });
          }),
    );
  }
}
