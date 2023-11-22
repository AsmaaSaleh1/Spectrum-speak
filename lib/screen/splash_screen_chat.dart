import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';
import 'package:universal_platform/universal_platform.dart';

import 'all_chat.dart';

class SplashChatScreen extends StatefulWidget {
  const SplashChatScreen({super.key});

  @override
  State<SplashChatScreen> createState() => _SplashChatScreenState();
}

class _SplashChatScreenState extends State<SplashChatScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const AllChat()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final isWeb = UniversalPlatform.isWeb;

    return Scaffold(
      body: Stack(
        children: [
          // App Logo
          Positioned(
            top: isWeb ? mq.height * 0.12 : mq.height * 0.2,
            left: isWeb ? mq.width * 0.25 : 0,
            width: isWeb ? mq.width * 0.5 : mq.width,
            height: mq.height * 0.5,
            child: Image.asset(
              'images/chatSplash.png',
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: isWeb ? mq.height * 0.12 : mq.height * 0.2,
            width: mq.width,
            child: Text(
              'Hello userName',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: kDarkerColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
