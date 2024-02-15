import 'dart:io';

import 'package:flutter/material.dart';

class CameraViewPage extends StatelessWidget {
  const CameraViewPage({super.key, required this.path});
  final dynamic path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.crop_rotate),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.title),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // color: Colors.black,
        child: Stack(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.file(
              File(path),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: 5,
                      minLines: 1,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                              color:
                                  Colors.teal, // Change to your desired color
                              width: 1.0,
                            ),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          hintText: 'Add Caption....',
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                 const SizedBox(width: 10,),
                  InkWell(
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.tealAccent,
                      child: Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
