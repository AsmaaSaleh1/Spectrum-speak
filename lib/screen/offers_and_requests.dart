import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/CenterNotification.dart';
import 'package:spectrum_speak/modules/CenterUser.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/screen/chat_screen.dart';
import 'package:spectrum_speak/widgets/center_information.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

String decisionMade = '';

class OfferorResponse extends StatefulWidget {
  final CenterNotification cn;
  late ChatUser? u;
  late CenterUser? c;
  Function(int,int)? callBack;
  OfferorResponse({super.key, required this.cn, this.u, this.c, this.callBack});

  @override
  State<OfferorResponse> createState() => _OfferorResponseState();
}

class _OfferorResponseState extends State<OfferorResponse> {
  String centerAdminId = '';
  String adminName = '';
  String admin = '';
  @override
  initState() {
    super.initState();
    setState(() {
      decisionMade = decisionMade;
    });
  }

  Future<void> getAdminID(String s) async {
    if (widget.cn.type == 'request')
      centerAdminId = await getSpecialistAdminForCenter(widget.cn.fromID);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return TopBar(
      body: Scaffold(
          backgroundColor: kPrimary,
          body: PopScope(
              onPopInvoked: (didPop) async {
                print('pop is ivoked');
                unreadMessagesCount=await Utils.getUnreadConversations(false);
                unreadNotificationsCount=await Utils.getUnreadNotifications('${AuthManager.u.UserID}');
                widget.callBack!(unreadMessagesCount,unreadNotificationsCount);
              },
              child: _showOfferWidget(context),
    )));
  }

  Widget _showOfferWidget(BuildContext context) {
    print('d $decisionMade');
    MediaQueryData mq = MediaQuery.of(context);
    String admin = '';
    getAdminName(widget.c!.centerID);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.size.width * 0.05),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        CircularProfileAvatar(
          '',
          borderWidth: 1.0,
          borderColor: kDarkerColor,
          backgroundColor: kPrimary,
          radius: 75.0,
          child: CachedNetworkImage(
            width: mq.size.height * .1,
            height: mq.size.height * .1,
            imageUrl: widget.c!.image,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover, // Set the fit property to cover
                ),
              ),
            ),
            errorWidget: (context, url, error) =>
                const CircleAvatar(child: Icon(CupertinoIcons.person)),
          ),
        ),
        Text('${widget.c!.centerName} Center',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: kDarkerColor)),
        CenterInformation(userId: widget.c!.centerID),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text:
                      'To get more details on ${widget.c!.centerName}\s offer, you can send their specialist',
                  style: TextStyle(
                      color: kDarkerBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.w800)),
              TextSpan(
                text: '$admin a message📥',
                style: TextStyle(
                    color: kRed, fontSize: 20, fontWeight: FontWeight.bold),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    // Handle 'Press' word tap
                    ChatUser u = await Utils.fetchUser(widget.c!.specialistID);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ChatScreen(user: u))));
                  },
              )
            ])),
        SizedBox(height: mq.size.height * 0.03),
        decisionMade == 'none'
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      child: Text('Accept',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      onPressed: () async {
                        print('accept');
                        setState(() {
                          decisionMade = 'accept';
                        });
                        CenterNotification response = CenterNotification(
                            fromID: widget.cn.toID,
                            toID: widget.cn.fromID,
                            type: 'response',
                            time: MyDateUtil.getCurrentDateTime(),
                            read: false,
                            value: true);
                        Utils.storeCenterNotification(response);
                        await addSpecialistToCenter(
                            widget.cn.toID, widget.cn.fromID);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                      )),
                  TextButton(
                      child: Text('Decline',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                      onPressed: () {
                        print('declined');
                        setState(() {
                          decisionMade = 'decline';
                        });
                        CenterNotification response = CenterNotification(
                            fromID: widget.cn.toID,
                            toID: widget.cn.fromID,
                            type: 'response',
                            time: MyDateUtil.getCurrentDateTime(),
                            read: false,
                            value: false);
                        Utils.storeCenterNotification(response);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kRed,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                      )),
                ],
              )
            : RichText(
                text: TextSpan(
                    text: decisionMade == 'accept'
                        ? 'You have accepted the offer✅'
                        : 'You have declined the offer❌',
                    style: TextStyle(
                        color: decisionMade == 'accept' ? kDarkerBlue : kRed,
                        fontWeight: FontWeight.w700,
                        fontSize: 19),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        print('tapped decision $decisionMade');
                      }))
      ]),
    );
  }

  Future<void> getAdminName(String id) async {
    admin = await getSpecialistAdminForCenter(id);
  }
}
