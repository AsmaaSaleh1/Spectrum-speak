import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/CenterNotification.dart';
import 'package:spectrum_speak/modules/CenterUser.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/my_date_util.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/screen/offers_and_requests.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class NotificationCard extends StatefulWidget {
  final CenterNotification cn;
  final ChatUser? u;
  final CenterUser? c;
  late Function(int,int)? callBack;
  NotificationCard({Key? key, required this.cn, this.u, this.c,this.callBack})
      : super(key: key);

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  late MediaQueryData mq; // Declare MediaQueryData variable
  String title = '';
  String subtitle = '';
  ChatUser user = new ChatUser();
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    if (widget.cn.type == 'request') {
      user.Name = widget.c!.centerName;
      title = '${user.Name} has offered you a spot!';
      user.image =
          (await Utils.getProfilePictureUrl(widget.cn.fromID!, 'Center'))!;
      print(user.image);
    } else if (widget.cn.type == 'response') {
      user.Name = widget.u!.Name;
      title = widget.cn.value!
          ? '${user.Name} has accepted your offer!'
          : '${user.Name} has declined your offer';
      user.image = (await Utils.getProfilePictureUrl(widget.cn.toID, ''))!;
    }

    subtitle = '${MyDateUtil.timeAgo(widget.cn.time!)}';
    print(title);
    print(subtitle);
    print('from ${widget.cn.fromID} to ${widget.cn.toID}');
    print('\n');
    // Ensure the widget is mounted before calling setState
    if (mounted) {
      setState(() {});
    }
  }

  void _updateData(int unreadM, int unreadN) {
    setState(() {
      unreadMessagesCount = unreadM;
      unreadNotificationsCount = unreadN;
    });
    print('im here it workeddd');
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context);

    // Use the title, trailing, and other data in your widget
    // return Text('MMM');
    // The rest of your widget code...
    return PopScope(
      onPopInvoked: (didPop) async{
        print('card popped');
        unreadMessagesCount=await Utils.getUnreadConversations(false);
        unreadNotificationsCount=await Utils.getUnreadNotifications('${AuthManager.u.UserID}');
        widget.callBack!(unreadMessagesCount,unreadNotificationsCount);
      },
      child: Card(
        elevation: 3,
        shadowColor: kDarkerColor,
        color: kPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
            onTap: () async {
              await Utils.updateNotificationReadStatus(widget.cn, true);

              setState(() {
                widget.cn.read = true;
              });
              if (widget.cn.type == 'request') {
                await Utils.retrieveOfferResponseValue(widget.cn);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => OfferorResponse(
                              cn: widget.cn,
                              c: widget.c,
                              callBack: _updateData,
                            )));
              } else {
                Utils.retrieveOfferResponseValue(widget.cn);
              }
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
                    imageUrl: user.image,
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
                trailing: !widget.cn.read!
                    ?
                    //unread notification
                    Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: kDarkerBlue,
                            borderRadius: BorderRadius.circular(10)),
                      )
                    : null)),
      ),
    );
  }
}
