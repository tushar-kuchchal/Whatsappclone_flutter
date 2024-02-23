// ignore_for_file: prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/reply_message_card.dart';
import 'package:full_stack_whatsapp_flutter/custom_widgets/self_message_card.dart';
import 'package:full_stack_whatsapp_flutter/model/chat_model.dart';
import 'package:full_stack_whatsapp_flutter/model/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualChats extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel? sourceChat;
  const IndividualChats({super.key, required this.chatModel, this.sourceChat});

  @override
  State<IndividualChats> createState() => _IndividualChatsState();
}

class _IndividualChatsState extends State<IndividualChats> {
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController=ScrollController();
  late IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages =[];
  @override
  void initState() {
    super.initState();
    connect();
    // Implement some initialization operations here.
  }

  void connect() {
    socket = IO.io('http://192.168.1.9:5000', <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect((data) {
      debugPrint("socket  client Connected");
      socket.on('message',(msg){
      
        debugPrint(msg.toString());
        setMessage('destination', msg['message']);
      });
    });
    socket.emit('login', widget.sourceChat!.id);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage('source', message);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
    });
    setState(() {
      sendButton=false;
    });
  }

  void setMessage(String  type, String message){
    MessageModel messageModel=MessageModel(message: message, type: type);
    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/whatsappbackground.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            titleSpacing: 10,
            leadingWidth: 75,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Icon(Icons.arrow_back_sharp),
                  SizedBox(
                    width: 5,
                  ),
                  CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 22,
                      child: ColorFiltered(
                        colorFilter:
                            ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        child: SvgPicture.asset(
                          'assets/images/${widget.chatModel.icon}',
                          height: 35,
                          width: 35,
                        ),
                      )),
                ],
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.chatModel.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
                Text(
                  'last seen today at 10:04 am',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                )
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: Icon(Icons.call)),
              PopupMenuButton(
                  color: Color.fromARGB(255, 19, 149, 134),
                  onSelected: (val) {
                    print(val);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        child: Text(
                          'View contact',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        value: 'View contact',
                      ),
                      PopupMenuItem(
                        child: Text(
                          'Media, links, and docs',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        value: 'Media, links, and docs',
                      ),
                      PopupMenuItem(
                        child: Text(
                          'Search',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        value: 'Search',
                      ),
                      PopupMenuItem(
                        child: Text(
                          'Mute Notifications',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        value: 'Mute Notifications',
                      ),
                      PopupMenuItem(
                        child: Text(
                          'Wallpaper',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        value: 'Wallpaper',
                      ),
                    ];
                  })
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 140,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: messages.length,
                    itemBuilder: (context,index){
                      if(messages[index].type=='source'){
                        return SelfMessageCard(message:messages[index].message ,);
                      }
                      else{
                        return ReplyMessageCard(message: messages[index].message,);
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 55,
                            child: Card(
                                margin: EdgeInsets.only(
                                    left: 8, right: 2, bottom: 8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                child: TextFormField(
                                  controller: controller,
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLines: 4,
                                  minLines: 1,
                                  keyboardType: TextInputType.multiline,
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        sendButton = true;
                                      });
                                    } else {
                                      setState(() {
                                        sendButton = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.emoji_emotions,
                                          color: Color.fromARGB(
                                              255, 135, 131, 131),
                                        ),
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      hintText: 'Type a message...',
                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    context: context,
                                                    builder: (builder) =>
                                                        bottomSheet());
                                              },
                                              icon: Icon(
                                                Icons.attachment_outlined,
                                                color: Color.fromARGB(
                                                    255, 135, 131, 131),
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.camera_alt,
                                                color: Color.fromARGB(
                                                    255, 135, 131, 131),
                                              )),
                                        ],
                                      )),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 2, bottom: 8, right: 1),
                            child: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 19, 149, 134),
                              radius: 24,
                              child: IconButton(
                                icon: Icon(
                                  sendButton ? Icons.send : Icons.mic,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (sendButton && controller.text.isNotEmpty) {
                                    _scrollController.animateTo(curve: Curves.easeOut,duration: Duration(milliseconds: 100),_scrollController.position.maxScrollExtent);
                                    sendMessage(
                                        controller.text,
                                        widget.sourceChat!.id,
                                        widget.chatModel.id);
                                    controller.clear();
                                  }
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      // emojiPicker(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 230,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCreating(
                      'Document', Icons.file_copy_outlined, Colors.indigo),
                  iconCreating(
                      'Camera', Icons.camera_alt_outlined, Colors.pink),
                  iconCreating(
                      'Gallery', Icons.insert_photo_outlined, Colors.purple),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  iconCreating(
                      'Audio', Icons.headset_mic_outlined, Colors.orange),
                  iconCreating('Location', Icons.location_pin, Colors.teal),
                  iconCreating('Contact', Icons.person_2_outlined, Colors.blue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreating(String name, IconData icon, Color color) {
    return Container(
      width: 85,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              color: Colors.white,
              size: 25,
            ),
          ),
          Text(
            name,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // selecet emogi from here
  // Widget emojiPicker() {
  //   return EmojiPicker(
  //     config: Config(
  //       height: 256,
  //       checkPlatformCompatibility: true,
  //       swapCategoryAndBottomBar: false,
  //       skinToneConfig: const SkinToneConfig(),
  //       emojiViewConfig: EmojiViewConfig(
  //           // Issue: https://github.com/flutter/flutter/issues/28894
  //           columns: 7),
  //       categoryViewConfig: const CategoryViewConfig(),
  //       bottomActionBarConfig: const BottomActionBarConfig(),
  //       searchViewConfig: const SearchViewConfig(),
  //     ),
  //     onEmojiSelected: (emoji, category) {
  //       print(emoji);
  //     },
  //   );
  // }
}
