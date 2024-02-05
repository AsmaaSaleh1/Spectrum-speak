import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/ContactUs.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/rest/rest_api_contact.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class ContactUsCard extends StatefulWidget {
  late Function(int)? callBack;
  late Contact? c;
  ContactUsCard({super.key, this.callBack, required this.c});

  @override
  State<ContactUsCard> createState() => _ContactUsCardState();
}

class _ContactUsCardState extends State<ContactUsCard> {
  ChatUser u = ChatUser();
  Future<void> assignUrl() async {
    u = await Utils.fetchUser(widget.c!.userID);
    setState(() {
      u = u;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignUrl();
    print(u.image);
    print(widget.c!.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return PopScope(
      onPopInvoked: (didPop) async {
        widget.callBack!(unreadAdminNCount != 0
                  ? unreadAdminNCount--
                  : unreadAdminNCount);
        setState(() {
          unreadAdminNCount = unreadAdminNCount;
        });
      },
      child: Card(
        elevation: 3,
        shadowColor: kDarkerColor,
        color: kPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
            onTap: () async {
              setState(() {
                widget.c!.done = 1;
              });
              widget.callBack!(unreadAdminNCount != 0
                  ? unreadAdminNCount--
                  : unreadAdminNCount);
              setState(() {
                unreadAdminNCount = unreadAdminNCount;
              });
            },
            child: Column(
              children: [
                ListTile(
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
                            const CircleAvatar(
                                child: Icon(CupertinoIcons.person)),
                      ),
                    ),
                    title: Text(
                      "${widget.c!.userName} has sent new feedback!",
                      maxLines: 3,
                      style: TextStyle(color: kDarkerColor),
                    ),
                    subtitle: Text(
                        MyDateUtil.timeAgo2(
                            widget.c!.dateTime.toString().split('.')[0]),
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                    trailing: widget.c!.done == 0
                        ?
                        //unread notification
                        Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: kDarkerBlue,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        : null),
              ],
            )),
      ),
    );
  }
}
