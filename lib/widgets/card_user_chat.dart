import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/screen/chat_screen.dart';

class CardUserChat extends StatefulWidget {
  const CardUserChat({super.key});

  @override
  State<CardUserChat> createState() => _CardUserChatState();
}

class _CardUserChatState extends State<CardUserChat> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: kDarkerColor,
      color: kPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder:(_)=>const ChatScreen()));
        },
        child: ListTile(
          leading: CircularProfileAvatar(
            '',
            borderWidth: 1.0,
            borderColor: kDarkerColor,
            backgroundColor: kPrimary,
            radius: 25.0,
            child: Image.asset(
              'images/prof.png',
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            "User Name",
            style: TextStyle(color: kDarkerColor),
          ),
          subtitle: const Text(
            "Last user message",
            maxLines: 1,
          ),
          trailing: Text("12:00 PM",
              style: TextStyle(color: kDarkerColor.withOpacity(0.8))),
        ),
      ),
    );
  }
}
