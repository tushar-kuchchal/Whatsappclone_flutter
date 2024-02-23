// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/button_card.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/contact_card.dart';
import 'package:full_stack_whatsapp_flutter/model/chat_model.dart';
import 'package:full_stack_whatsapp_flutter/screens/add_group.dart';

class SelectContacct extends StatefulWidget {
  const SelectContacct({super.key});

  @override
  State<SelectContacct> createState() => _SelectContacctState();
}

class _SelectContacctState extends State<SelectContacct> {
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  List<ChatModel> selectContact = [
    ChatModel(name: 'Mitrsen Yadav', status: 'IAS',  id:1, icon: 'personIcon.svg'),
    ChatModel(name: 'Vaishali', status: 'Busy',  id:2, icon: 'personIcon.svg'),
    ChatModel(
        name: 'Harsh 2',
          id:3,
        status: 'Hey there, I am usign whatsapp',
        icon: 'personIcon.svg'),
    ChatModel(name: 'Home',  id:4, status: 'lonely', icon: 'personIcon.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Contact',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Text(
              '256 contacts',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton(
              color: Color.fromARGB(255, 19, 149, 134),
              onSelected: (val) {
                print(val);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: Text(
                      'Invite a friend',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    value: 'Invite a friend',
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Contacts',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    value: 'Contacts',
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Refresh',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    value: 'Refresh',
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Help',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    value: 'Help',
                  ),
                ];
              })
        ],
      ),
      body: ListView.builder(
          itemCount: selectContact.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              return ButtonCard(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (ctx) => AddGroup()));
                },
                name: 'New group',
                icon: Icons.group,
              );
            }
            if (index == 1) {
              return ButtonCard(
                  onTap: () {}, icon: Icons.person_add, name: 'New contact');
            }
            return ContactCard(chatmodel: selectContact[index - 2]);
          }),
    );
  }
}
