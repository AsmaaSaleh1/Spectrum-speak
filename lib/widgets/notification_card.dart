import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/CenterNotification.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/Message.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/screen/chat_screen.dart';

class NotificationCard extends StatefulWidget {
  final CenterNotification cn;

  NotificationCard({Key? key, required this.cn}) : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  late MediaQueryData mq; // Declare MediaQueryData variable
  late String title;
  late String subtitle;
  late ChatUser u;
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    if (widget.cn.type == 'request') {
      String centerName = await getCenterName(widget.cn.fromID!);
      title = '$centerName has offered you a spot!';
    } else if (widget.cn.type == 'response' && widget.cn.value) {
      String specialistName =
          await getSpecialistAdminForCenter(widget.cn.toID!);
      title = '$specialistName has accepted your offer';
    }

    subtitle = '${MyDateUtil.timeAgo(widget.cn.time)}';
    u = await Utils.fetchUser('${widget.cn.toID}');
    print(title);
    print(widget.cn.toID);
    print(subtitle);
    // Ensure the widget is mounted before calling setState
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);

    // Use the title, trailing, and other data in your widget
    // return Text('MMM');
    // The rest of your widget code...
    return Card(
      elevation: 3,
      shadowColor: kDarkerColor,
      color: kPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (_) => ChatScreen(user: widget.user!)));
          },
          child: ListTile(
              leading: CircularProfileAvatar(
                '',
                borderWidth: 1.0,
                borderColor: kDarkerColor,
                backgroundColor: kPrimary,
                radius: 25.0,
                child: CachedNetworkImage(
                  width: mq.size.height * .05,
                  height: mq.size.height * .05,
                  imageUrl: u.image,
                  errorWidget: (context, url, error) =>
                      const CircleAvatar(child: Icon(CupertinoIcons.person)),
                ),
              ),
              title: Text(
                title,
                style: TextStyle(color: kDarkerColor),
              ),
              subtitle: Text(subtitle,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold)),
              trailing:
                      //unread notification
                      Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                              color: !widget.cn.read?kDarkerBlue:kPrimary,
                              borderRadius: BorderRadius.circular(10)),
                        )
                    )),
    );
  }
}
