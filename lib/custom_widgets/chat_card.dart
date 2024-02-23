// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/individual_chat.dart';
import 'package:full_stack_whatsapp_flutter/model/chat_model.dart';

class ChatCard extends StatelessWidget {
 final ChatModel chatmodel;
 final ChatModel sourceChat;
  const ChatCard({super.key,required this.chatmodel, required this.sourceChat});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> IndividualChats(chatModel: chatmodel, sourceChat:sourceChat)));
            
          },
          child: ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 25,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  child: SvgPicture.asset(
                    'assets/images/${chatmodel.icon}',
                    height: 35,
                    width: 35,
                  ),
                )),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  chatmodel.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
                Text(
                 chatmodel.time?? '',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 101, 97, 97)),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Icon(
                  Icons.done_all,
                  size: 18,
                  color: Colors.blue,
                ),
                Expanded(
                    child: Text(
                  chatmodel.currentMessage ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 101, 97, 97)),
                ))
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 80,right: 20),
          child: Divider(
            thickness: 1,
          ),
        )
      ],
    );
  }
}
