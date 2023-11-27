import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/widgets/card_user_chat.dart';

class AllChat extends StatefulWidget {
  const AllChat({super.key});

  @override
  State<AllChat> createState() => _AllChatState();
}

class _AllChatState extends State<AllChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat",
        ),
        leading: const Icon(CupertinoIcons.house),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kDarkBlue,
        child: const Icon(
          Icons.add_comment_rounded,
          color: kPrimary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        child: ListView.builder(
            itemCount: 20,
            padding: const EdgeInsets.only(top: 8),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return const CardUserChat();
            }),
      ),
    );
  }
}
