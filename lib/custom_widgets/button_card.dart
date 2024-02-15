// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String name;

  const ButtonCard(
      {super.key,
      required this.icon,
      required this.name,
      required this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          radius: 25,
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
