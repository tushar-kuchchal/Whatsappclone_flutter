// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:full_stack_whatsapp_flutter/model/chat_model.dart';
import 'package:full_stack_whatsapp_flutter/pages/camera.dart';
import 'package:full_stack_whatsapp_flutter/pages/chats.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.chats,required this.sourceChat});
  final List<ChatModel> chats;
  final ChatModel sourceChat;


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Whatsapp clone ',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            PopupMenuButton(
              color: Color.fromARGB(255, 19, 149, 134),
              onSelected: (val){
                debugPrint(val);
              },

              itemBuilder: (BuildContext context) {
               
              return [
                PopupMenuItem(child: Text('New Group',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),), value: 'New Group',),
                PopupMenuItem(child: Text('whatsapp web',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),value: 'Whatsapp web',),
                PopupMenuItem(child: Text('New broadcast',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),), value: 'New broadcast',),
                PopupMenuItem(child: Text('Stared message',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),value: 'Stared message',),
                PopupMenuItem(child: Text('Setting',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),),value: 'Setting',),
              ];
            })
          ],
          bottom: const TabBar(
              indicatorColor: Colors.white,
              labelStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),
              unselectedLabelColor: Color.fromARGB(255, 32, 51, 33),
              
              tabs: [
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(
                  text: 'CHATS',
                ),
                Tab(
                  text: 'STATUS',
                ),
                Tab(
                  text: 'CALLS',
                ),
              ]),
        ),
        body:  TabBarView(children: [
          CameraPage(),
         Chats(chats:widget.chats, sourceChat: widget.sourceChat),
          Text('STATUS'),
          Text('CALLS'),
        ]),
      ),
    );
  }
}
