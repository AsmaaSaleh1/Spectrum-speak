import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/Message.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/screen/chat_screen.dart';

class CardUserChat extends StatefulWidget {
  final ChatUser? user;
  const CardUserChat({super.key, this.user});

  @override
  State<CardUserChat> createState() => _CardUserChatState();
}

class _CardUserChatState extends State<CardUserChat> {
  late MediaQueryData mq; // Declare MediaQueryData variable
  String? url;
  Message? _message;


  @override
  initState() {
    // TODO: implement initState
    super.initState();
    print('userID: ${widget.user!.UserID}       ${widget.user!.image}');
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);
    return Card(
      elevation: 3,
      shadowColor: kDarkerColor,
      color: kPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(user: widget.user!)));
          },
          child: StreamBuilder(
              stream: Utils.getLastMessage(widget.user!),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
                if (list.isNotEmpty) 
                  _message = list[0];
                return ListTile(
                    leading: CircularProfileAvatar(
                      '',
                      borderWidth: 1.0,
                      borderColor: kDarkerColor,
                      backgroundColor: kPrimary,
                      radius: 25.0,
                      child: CachedNetworkImage(
                        width: mq.size.height * .05,
                        height: mq.size.height * .05,
                        imageUrl:widget.user!.image,
                        errorWidget: (context, url, error) => const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                        ),
                    ),
                    title: Text(
                      widget.user!.Name,
                      style: TextStyle(color: kDarkerColor),
                    ),
                    subtitle: Text(_message!=null?
                    _message?.type==Type.text.toString()?
                      _message!.message:'Sent a photo'
                    :'',
                      maxLines: 1,style:TextStyle(color:Colors.black54,fontWeight: FontWeight.bold)
                    ),
                    trailing: _message==null?null:
                    _message!.read.isEmpty&&_message?.fromID!=AuthManager.u.UserID?
                    //unread message
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color: kDarkerBlue,
                          borderRadius: BorderRadius.circular(10)),
                    )
                    :Text(MyDateUtil.getLastMessageTime(context:context,time: _message!.sent),
                        style:TextStyle(color: Colors.black54))
                    );
              })),
    );
  }
}
