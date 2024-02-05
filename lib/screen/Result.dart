import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../constant/const_color.dart';

class Result extends StatefulWidget {
  late int result;
  Result({Key? key, required this.result}) : super(key: key);

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
  List<String> cardResult = [
    "No Concern",
    "Mild Signs",
    "Moderate\nIndication",
    "High Risk"
  ];
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
    widget.result = 2;
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

    _controllerResult =
        VideoPlayerController.asset('images/indicatorLevel${widget.result}.mp4')
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
              if(!kIsWeb)
              Column(
                children: [
                  if(!kIsWeb) SizedBox(height: 30),
                  Container(
                    width: kIsWeb?MediaQuery.of(context).size.width * 0.4:MediaQuery.of(context).size.width * 0.8,
                    height:kIsWeb?MediaQuery.of(context).size.width * 0.4: MediaQuery.of(context).size.width *0.8, // Adjust the height as needed
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Center(child:Image.asset(
                            'images/resultHolder.png',
                            width: kIsWeb
                                ? MediaQuery.of(context).size.width * 0.4
                                : MediaQuery.of(context).size.width * 0.8,
                          ),)
                        ),
                        // Text positioned on top of the image
                        Padding(
                          padding: const EdgeInsets.only(top: kIsWeb?10:50.0),
                          child: Center(
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
                      margin: EdgeInsets.only(top: widget.result > 2 ? 30 : 10),
                      width: widget.result > 2
                          ? kIsWeb?MediaQuery.of(context).size.width * 0.2:MediaQuery.of(context).size.width * 0.4
                          : kIsWeb?MediaQuery.of(context).size.width * 0.15:MediaQuery.of(context).size.width * 0.3,
                      alignment: Alignment.center,
                      child: _controllerResult.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controllerResult.value.aspectRatio,
                              child: VideoPlayer(_controllerResult),
                            )
                          : Container(),
                    ),
                  Center(
                      child: Text('Disclaimer',
                          style: TextStyle(
                              color: kDarkBlue, fontStyle: FontStyle.italic))),
                  Center(
                      child: Text(
                          'This autism test is for informational purposes only and does not replace professional advice. Consult with a specialist for accurate diagnosis and guidance.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kDarkBlue,
                              fontSize: 12,
                              fontStyle: FontStyle.italic)))
                ],
              ),
              if(kIsWeb)
              Row(children:[
              Column(
                children: [
                  if(!kIsWeb) SizedBox(height: 30),
                  Container(
                    width: kIsWeb?MediaQuery.of(context).size.width * 0.4:MediaQuery.of(context).size.width * 0.8,
                    height:kIsWeb?MediaQuery.of(context).size.width * 0.4: MediaQuery.of(context).size.width *0.8, // Adjust the height as needed
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Center(child:Image.asset(
                            'images/resultHolder.png',
                            width: kIsWeb
                                ? MediaQuery.of(context).size.width * 0.4
                                : MediaQuery.of(context).size.width * 0.8,
                          ),)
                        ),
                        // Text positioned on top of the image
                        Padding(
                          padding: const EdgeInsets.only(top: kIsWeb?70:50.0),
                          child: Center(
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
                  ),]),
                  Column(children:[
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 100),
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
                      margin: EdgeInsets.only(top: widget.result > 2 ? 30 : 10),
                      width: widget.result > 2
                          ? kIsWeb?MediaQuery.of(context).size.width * 0.2:MediaQuery.of(context).size.width * 0.4
                          : kIsWeb?MediaQuery.of(context).size.width * 0.15:MediaQuery.of(context).size.width * 0.3,
                      alignment: Alignment.center,
                      child: _controllerResult.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controllerResult.value.aspectRatio,
                              child: VideoPlayer(_controllerResult),
                            )
                          : Container(),
                    ),
                  Center(
                      child: Text('Disclaimer',
                          style: TextStyle(
                              color: kDarkBlue, fontStyle: FontStyle.italic))),
                  Center(
                      child: Text(
                          'This autism test is for informational purposes only and does not replace professional advice. Consult with a specialist for accurate\ndiagnosis and guidance.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: kDarkBlue,
                              fontSize: 12,
                              fontStyle: FontStyle.italic)))])
                ],
              ),
          ],
        ));
  }
}
