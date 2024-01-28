import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../constant/const_color.dart';

class Result extends StatefulWidget {
  final int result;
  const Result({Key? key, required this.result}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  bool _showVideo = true;
  late VideoPlayerController _controller;
  late Timer _timer;
  bool _swipeDismissed = false;
  bool _showText = false;
  late VideoPlayerController _controllerResult;
  List<String> cardResult=["No Concern","Mild Signs","Moderate\nIndication","High Risk"];
  List<String> messageResult = [
    "No notable indications of autism traits. Continued monitoring and regular check-ups are recommended",
    "It's advisable to seek professional evaluation and guidance for further understanding and support",
    "It's important to quickly seek professional help for proper support and guidance",
    "It's crucial to promptly consult healthcare professionals specializing in autism spectrum disorders for a thorough evaluation"
  ];
  List<String> res = [
    "No significant autism traits detected",
    "Mild autism traits detected",
    "Moderate autism traits detected",
    "High risk of autism detected",
  ];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('images/secondavatar.mp4')
      ..initialize().then((_) {
        setState(() {});
        _playVideoLoop();
      })
      ..setVolume(0.0);

    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration!) {
        _controller.seekTo(Duration.zero);
        _controller.play();
      }
    });

    _controllerResult = VideoPlayerController.asset('images/indicatorLevel${widget.result}.mp4')
      ..initialize().then((_) {})
      ..setVolume(0.0);
  }

  void _playVideoLoop() {
    _controller.play();

    _timer = Timer(Duration(seconds: 6), () {
      setState(() {
        _swipeDismissed = true;
        _showVideo = false;
      });

      // Add a delay of 1 second before showing the text container
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _showText = true;
          _controllerResult.play(); // Play the result video
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerResult.dispose(); // Dispose the result video controller
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: const Text(
          'Spectrum Quiz',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: kPrimary,
          ),
        ),
      ),
      backgroundColor: kPrimary,
      body: Stack(
  children: [
    AnimatedPositioned(
      duration: Duration(milliseconds: 1200),
      top: _swipeDismissed ? MediaQuery.of(context).size.height : 0.0,
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            setState(() {
              _swipeDismissed = true;
              _showVideo = false;
            });
          }
        },
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 60, top: 120),
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.5,
            alignment: Alignment.topCenter,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
        ),
      ),
    ),
    if (!_showVideo && _swipeDismissed && _showText)
      Column(
        children: [
          SizedBox(height: 35),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8, // Adjust the height as needed
            child: Stack(
              children: [
                Image.asset(
                  'images/resultHolder.png',
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
                // Text positioned on top of the image
                Positioned(
                  top: 200,
                  left: MediaQuery.of(context).size.width * 0.2 - 75,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      cardResult[widget.result],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kRed,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 40),
            child: Text(
              res[widget.result],
              style: TextStyle(
                fontFamily: GoogleFonts.heebo().fontFamily,
                fontSize: 19,
                fontWeight: FontWeight.w800,
                color: kDarkBlue,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Text(
              messageResult[widget.result],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: GoogleFonts.heebo().fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kBlue,
              ),
            ),
          ),
          if (!_showVideo && _swipeDismissed && _showText)
            Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.center,
              child: _controllerResult.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controllerResult.value.aspectRatio,
                      child: VideoPlayer(_controllerResult),
                    )
                  : Container(),
            ),
        ],
      ),
  ],
)

    );
  }
}
