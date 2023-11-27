import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: _appBar(),
        ),
        backgroundColor: kPrimary,
      ),
    );
  }

  Widget _appBar() {
    return InkWell(
      onTap: (){},
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            color: kPrimary,
          ),
          CircularProfileAvatar(
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
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Name",
                style: TextStyle(
                    color: kPrimary.withOpacity(0.95),
                  fontWeight: FontWeight.w500,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 2,),
              Text(
                "Last seen recently",
                style: TextStyle(
                  color: kPrimary.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
