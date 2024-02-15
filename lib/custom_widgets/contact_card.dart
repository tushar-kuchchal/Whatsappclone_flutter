// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/individual_chat.dart';
import 'package:full_stack_whatsapp_flutter/model/chat_model.dart';

class ContactCard extends StatelessWidget {
  final ChatModel chatmodel;
  final IconData? profileIcon;
  final VoidCallback? onTap;
  const ContactCard(
      {super.key, required this.chatmodel, this.profileIcon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTap != null
                ? onTap!()
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            IndividualChats(chatModel: chatmodel)));
          },
          child: ListTile(
            leading: SizedBox(
              height: 53,
              width: 53,
              child: Stack(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 25,
                      child: ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        child: SvgPicture.asset(
                          'assets/images/${chatmodel.icon}',
                          height: 35,
                          width: 35,
                        ),
                      )),
                  if (profileIcon != null)
                    Positioned(
                        bottom: 1,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.teal,
                          radius: 12,
                          child: Icon(
                            profileIcon,
                            size: 15,
                            color: Colors.white,
                          ),
                        ))
                ],
              ),
            ),
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
              ],
            ),
            subtitle: Row(
              children: [
                Expanded(
                    child: Text(
                  chatmodel.status ?? '',
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
      ],
    );
  }
}
