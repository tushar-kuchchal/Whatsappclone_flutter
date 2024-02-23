// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/contact_card.dart';
import 'package:full_stack_whatsapp_flutter/model/chat_model.dart';

class AddGroup extends StatefulWidget {
  const AddGroup({super.key});

  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  List<ChatModel> contacts = [
    ChatModel(
        name: 'Saksham',
        icon: 'personIcon.svg',
        status: 'Flutter Developer',
        id: 1,
        selected: false),
    ChatModel(
        name: 'Surya Pratap',
        icon: 'personIcon.svg',
        status: 'ios Developer',
        id: 2,
        selected: false),
    ChatModel(
        name: 'Mandeep singh',
        icon: 'personIcon.svg',
        id: 3,
        status: 'senior Android Developer',
        selected: false),
    ChatModel(
        name: 'Krishan Dev',
        icon: 'personIcon.svg',
        id: 4,
        status: 'React Native Developer',
        selected: false),
    ChatModel(
        name: 'Tushar Kuchchal',
        icon: 'personIcon.svg',
        id: 5,
        status: 'Flutter and React Native Developer',
        selected: false),
    ChatModel(
        name: ' Mo. Saif',
        icon: 'personIcon.svg',
        status: 'Php Developer',
        id: 6,
        selected: false),
    ChatModel(
        name: 'sarthak',
        icon: 'personIcon.svg',
        id: 7,
        status: 'Full Stack Developer',
        selected: false),
    ChatModel(
        name: 'Ashu saini',
        icon: 'personIcon.svg',
        id: 8,
        status: 'Node js Developer',
        selected: false),
    ChatModel(
        name: 'Kuldeep yadav',
        icon: 'personIcon.svg',
        id: 9,
        status: 'React Native Developer',
        selected: false)
  ];

  List<ChatModel> newgroupList = [];
  @override
  void initState() {
    super.initState();
    // Implement some initialization operations here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: newgroupList.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.arrow_right_alt_sharp),
            )
          : null,
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New Group',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Text(
              '${newgroupList.length} of ${contacts.length} selected',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Column(
        children: [
          newgroupList.isNotEmpty
              ? Container(
                  padding: EdgeInsets.all(10),
                  height: 100,
                  child: ListView.builder(
                      itemCount: newgroupList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              newgroupList[index].selected = false;
                              newgroupList.removeAt(index);
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            height: 80,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 60,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: Colors.blueGrey,
                                          radius: 25,
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                Colors.white, BlendMode.srcIn),
                                            child: SvgPicture.asset(
                                              'assets/images/${newgroupList[index].icon}',
                                              height: 35,
                                              width: 35,
                                            ),
                                          )),
                                      Positioned(
                                          top: 30,
                                          right: 0,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.teal,
                                            radius: 12,
                                            child: Icon(
                                              Icons.close,
                                              size: 15,
                                              color: Colors.white,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Text(
                                  newgroupList[index].name.split(' ')[0],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                )
              : SizedBox(),
          if (newgroupList.isNotEmpty) Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactCard(
                    chatmodel: contacts[index],
                    profileIcon:
                        contacts[index].selected == true ? Icons.done : null,
                    onTap: () {
                      setState(() {
                        if (contacts[index].selected == true) {
                          newgroupList.remove(contacts[index]);
                          contacts[index].selected = false;
                        } else {
                          contacts[index].selected = true;
                          newgroupList.add(contacts[index]);
                        }
                      });
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
