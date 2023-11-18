import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';

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
        child: const Icon(Icons.add_comment_rounded,color: kPrimary,),
      ),
    );
  }
}
