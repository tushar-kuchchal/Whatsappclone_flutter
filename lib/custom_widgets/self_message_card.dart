// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SelfMessageCard extends StatelessWidget {
  const SelfMessageCard({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width-45,
        ),

        child: Card( 
          elevation: 1,
          color:Color(0xffdcf8c6) ,
          margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          child: Stack( 
            children: [ 
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 60,top: 10,bottom: 20),
                child: Text(message,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Row(
                  children: [ 
                    Text('8:25',style: TextStyle(fontSize: 12, fontWeight:FontWeight.w500,color: Colors.grey[600])),
                    SizedBox(width: 5,),
                    Icon(Icons.done_all,size: 15,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}