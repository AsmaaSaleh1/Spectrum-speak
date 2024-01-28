import 'dart:async';
import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/CenterNotification.dart';
import 'package:spectrum_speak/modules/CenterUser.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/specialist.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/rest/rest_api_login.dart';
import 'package:spectrum_speak/rest/rest_api_menu.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/rest/rest_api_profile_delete.dart';
import 'package:spectrum_speak/screen/Quiz.dart';
import 'package:spectrum_speak/screen/center_profile.dart';
import 'package:spectrum_speak/screen/spectrum_bot.dart';
import 'package:spectrum_speak/screen/contact_us.dart';
import 'package:spectrum_speak/screen/login.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/screen/search_page.dart';
import 'package:spectrum_speak/screen/shadow_teacher_profile.dart';
import 'package:spectrum_speak/screen/specialist_profile.dart';
import 'package:spectrum_speak/screen/splash_screen_chat.dart';
import 'package:spectrum_speak/screen/calendar_grid.dart';
import 'package:spectrum_speak/widgets/notification_card.dart';
import 'package:tuple/tuple.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'card_user_chat.dart';

int unreadMessagesCount = 0;
int unreadNotificationsCount = 0;
List<ChatUser> popUpMenuList = [];
bool topBarGuide = true;
CenterNotification cn = CenterNotification(
    fromID: "2",
    time: "2024/01/19 11:00 PM",
    toID: "3",
    read: false,
    type: "request",
    value: false);

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  CustomAppBar({
    super.key,
    required this.scaffoldKey,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late bool? showNotif = false;
  String category = '';
  TutorialCoachMark? tutorialCoachMark;
  List<TargetFocus>? targets;
  GlobalKey profileKey = GlobalKey();
  GlobalKey notificationsKey = GlobalKey();
  GlobalKey calendarKey = GlobalKey();
  GlobalKey inboxKey = GlobalKey();
  GlobalKey menuKey = GlobalKey();
  GlobalKey spectrumBotKey = GlobalKey();
  @override
  initState() {
    if (AuthManager.firstTime && topBarGuide)
      Future.delayed(const Duration(seconds: 1), () {
        _showTutorialCoachmark();
      });
    super.initState();
    setState(() {
      Future.delayed(Duration.zero, () async {
        await updateShowNotif();
        setState(() {});
      });
    });
  }

  void _showTutorialCoachmark() {
    topBarGuide = false;
    _initTarget();
    tutorialCoachMark = TutorialCoachMark(
      targets: targets!,
      pulseEnable: false,
      colorShadow: tutorialColor,
      onClickTarget: (target) {
        print("${target.identify}");
      },
      hideSkip: true,
      alignSkip: Alignment.topRight,
      onFinish: () {
        print("Finish");
        topBarGuide = false;
      },
    )..show(context: context);
  }

  void _initTarget() {
    targets = [
      // profile
      TargetFocus(
        identify: "profile-key",
        keyTarget: profileKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                next: "Start👏",
                text:
                    "Hello there!👋This is your Spectrum Speak Buddy🤖! I'll be here to assist you on how to use Spectrum Speak to the fullest and to introduce you to its features! Let's get started💪",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "profile-key",
        keyTarget: profileKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Tap on your profile picture icon to access your profile!",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "notifications-key",
        keyTarget: notificationsKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Tap on this Notifications bell to view your notifications!",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "calendar-key",
        keyTarget: calendarKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "You're one click away from your Sepctrum Speak Calendar! Here you can view events near you or manage bookings!",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "inbox-key",
        keyTarget: inboxKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Tap the Inbox icon to access your messages. Stay informed, manage important updates, and keep your communication in check!",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
      TargetFocus(
        identify: "menu-key",
        keyTarget: menuKey,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return CoachmarkDesc(
                text:
                    "Tap on the menu to discover more of Spectrum's Speak features",
                onNext: () {
                  controller.next();
                },
                onSkip: () {
                  controller.skip();
                },
              );
            },
          )
        ],
      ),
    ];
  }

  Future<void> updateShowNotif() async {
    category = await getUserCategory(AuthManager.u.UserID.toString());
    if (category == 'Specialist') {
      showNotif = true;
    }
  }

  void _updateData(int unreadM, int unreadN) {
    setState(() {
      unreadMessagesCount = unreadM;
      unreadNotificationsCount = unreadN;
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return FutureBuilder<List<int>>(
        future: Future.wait([
          Utils.getUnreadConversations(false),
          if (showNotif!)
            Utils.getUnreadNotifications(AuthManager.u.UserID.toString()),
          if (showNotif == false) Future(() => 9)
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            unreadMessagesCount = snapshot.data![0] ?? 0;
            if (showNotif!)
              unreadNotificationsCount = snapshot.data![1];
            else {
              unreadNotificationsCount = 0;
            }
          }
          return AppBar(
            leading: IconButton(
              icon: Icon(
                key: menuKey,
                CupertinoIcons.list_bullet,
                color: kPrimary,
                size: 30,
              ),
              onPressed: () {
                widget.scaffoldKey.currentState?.openDrawer();
              },
            ),
            actions: [
              badges.Badge(
                badgeContent: Text(
                  '$unreadMessagesCount',
                  style: TextStyle(color: kPrimary),
                ),
                animationType: BadgeAnimationType.slide,
                animationDuration: Duration(milliseconds: 1200),
                badgeColor: kRed,
                position: badges.BadgePosition.topEnd(top: 0, end: 3),
                child: IconButton(
                  onPressed: () async {
                    await Utils.getUnreadConversations(true);
                    _showMessagesPopUpMenu(context, popUpMenuList);
                  },
                  icon: Icon(
                    key: inboxKey,
                    CupertinoIcons.envelope_open,
                    color: kPrimary,
                    size: 30,
                  ),
                ),
              ),
              IconButton(
                key: calendarKey,
                onPressed: () async {
                  print('Calendar button pressed');
                  String city = await getCity('${AuthManager.u.UserID}');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CalendarPage(city: city, category: category)));
                },
                icon: const Icon(
                  CupertinoIcons.calendar,
                  color: kPrimary,
                  size: 30,
                ),
              ),
              badges.Badge(
                badgeContent: Text(
                  '$unreadNotificationsCount',
                  style: TextStyle(color: kPrimary),
                ),
                animationType: BadgeAnimationType.slide,
                animationDuration: Duration(milliseconds: 1200),
                badgeColor: kRed,
                position: badges.BadgePosition.topEnd(top: 0, end: 3),
                child: IconButton(
                  onPressed: () async {
                    print('Notification button pressed');
                    print(await AuthManager.u.UserID);
                    String category =
                        await getUserCategory(AuthManager.u.UserID.toString());
                    Specialist? s;
                    if (category == 'Specialist') {
                      s = await profileSpecialist(
                          await '${AuthManager.u.UserID}');
                      if (s!.admin)
                        _showNotificationsPopUpMenu(
                            context,
                            await Utils.getNotifications(
                                'Center', s!.centerID));
                      else
                        _showNotificationsPopUpMenu(
                            context,
                            await Utils.getNotifications(
                                'Specialist', s!.userID));
                    }
                  },
                  icon: Icon(
                    key: notificationsKey,
                    CupertinoIcons.bell,
                    color: kPrimary,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                key:profileKey,
                padding: const EdgeInsets.all(8.0),
                child: CircularProfileAvatar(
                  '',
                  borderWidth: 1.0,
                  borderColor: kPrimary.withOpacity(0.5),
                  radius: 20.0,
                  backgroundColor: kPrimary,
                  child: CachedNetworkImage(
                    width: mq.size.height * .1,
                    height: mq.size.height * .1,
                    imageUrl: AuthManager.u.image,
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

                  onTap: () async {
                    String? userId = await AuthManager.getUserId();
                    String category = await getUserCategory(userId!);
                    switch (category) {
                      case "Parent":
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ParentProfile(
                              userID: userId,
                            ),
                          ),
                        );
                        break;
                      case "Specialist":
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SpecialistProfile(
                              userId: userId,
                            ),
                          ),
                        );
                        break;
                      case "ShadowTeacher":
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShadowTeacherProfile(
                              userId: userId,
                            ),
                          ),
                        );
                        break;
                      default:
                        print("error in category");
                        break;
                    }
                  },
                  //child: ProfileImageDisplay(updateStreamController: updateStreamController,),
                ),
              )
            ],
          );
        });
  }

  void _showMessagesPopUpMenu(BuildContext context, List<ChatUser> list) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    await showMenu(
      color: kPrimary,
      context: context,
      position: RelativeRect.fromLTRB(
        overlay.size.width - 50, // Adjust the value as needed
        53, // Y position, set to 0 for top
        overlay.size.width, // Right edge of the screen
        MediaQuery.of(context).size.height, // Bottom edge of the screen
      ),
      items: [
        PopupMenuItem(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            width: 300,
            child: Column(
              children: [
                for (int i = 0; i < list.length; i++)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: CardUserChat(user: list[i]),
                  ),
                ListTile(
                  title: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SplashChatScreen()),
                      );
                    },
                    child: Text(
                      list.isEmpty ? 'Start Chatting Now' : 'Show All Messages',
                      style: TextStyle(
                          color: kDarkerColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showNotificationsPopUpMenu(
      BuildContext context, List<CenterNotification> list) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    List<dynamic> u = [];

    for (int i = 0; i < list.length; i++) {
      if (list[i].type == 'response') {
        ChatUser user = await Utils.fetchUser(list[i].fromID);
        u.add(user);
      } else {
        CenterUser user = await Utils.fetchCenter(list[i].fromID);
        u.add(user);
      }
    }

    // Now use list in your logic
    list.sort((a, b) {
      DateTime timeA = DateFormat('yyyy/MM/dd hh:mm a').parse(a.time!);
      DateTime timeB = DateFormat('yyyy/MM/dd hh:mm a').parse(b.time!);
      return timeB.compareTo(timeA); // Descending order
    });

    await showMenu(
      color: kPrimary,
      context: context,
      position: RelativeRect.fromLTRB(
        overlay.size.width - 50, // Adjust the value as needed
        53, // Y position, set to 0 for top
        overlay.size.width, // Right edge of the screen
        MediaQuery.of(context).size.height, // Bottom edge of the screen
      ),
      items: [
        PopupMenuItem(
          padding: const EdgeInsets.all(0),
          child: SizedBox(
            width: 300,
            child: Column(
              children: [
                for (int i = 0; i < list.length; i++)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: list[i].type == 'request'
                        ? NotificationCard(
                            cn: list[i],
                            c: u[i],
                            callBack: _updateData,
                          ) //Center notification card
                        : NotificationCard(
                            cn: list[i],
                            u: u[i],
                            callBack: _updateData,
                          ), //Specialist notificatiod card
                  ),
                ListTile(
                  title: TextButton(
                    onPressed: () {},
                    child: Text(
                      list.isNotEmpty
                          ? 'That\'s it😁'
                          : 'You have not received any notifications yet!',
                      style: TextStyle(
                          color: kDarkerColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TopBar extends StatelessWidget {
  final Widget body;

  TopBar({
    super.key,
    required this.body,
  });

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String url = '';

  Future<void> assignUrl() async {
    String centerID =
        (await getCenterIdForSpecialist(AuthManager.u.UserID.toString()))!;
    CenterUser c = await Utils.fetchCenter(centerID);
    await (url = c.image);
      url = url;
    print('$url');
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return FutureBuilder<Tuple5<String?, String?, String?, bool?, String?>>(
        future: _getEmailNameAndCategory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // You can return a loading indicator here if needed
            return Container(
              color: kPrimary,
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  backgroundColor: kDarkBlue,
                  color: kDarkBlue,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle the error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Access the data from the tuple
            String? email = snapshot.data!.item1;
            String? userName = snapshot.data!.item2;
            String? category = snapshot.data!.item3;
            bool? isAdmin = snapshot.data!.item4;
            String? userId = snapshot.data!.item5;
            return Scaffold(
              key: _scaffoldKey,
              appBar: CustomAppBar(scaffoldKey: _scaffoldKey),
              drawer: Drawer(
                shadowColor: kDarkerColor,
                backgroundColor: kPrimary,
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        userName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: kPrimary,
                        ),
                      ),
                      accountEmail: Text(
                        email ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: kPrimary,
                        ),
                      ),
                      currentAccountPicture: CircularProfileAvatar(
                        '',
                        borderWidth: 1.0,
                        borderColor: kDarkerBlue,
                        backgroundColor: kPrimary,
                        radius: 50.0,
                        child: CachedNetworkImage(
                          width: mq.size.height * .05,
                          height: mq.size.height * .05,
                          imageUrl: AuthManager.u.image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit
                                    .cover, // Set the fit property to cover
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const CircleAvatar(
                                  child: Icon(CupertinoIcons.person)),
                        ),
                        onTap: () async {
                          switch (category) {
                            case "Parent":
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParentProfile(
                                    userID: userId!,
                                  ),
                                ),
                              );
                              break;
                            case "Specialist":
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpecialistProfile(
                                    userId: userId!,
                                  ),
                                ),
                              );
                              break;
                            case "ShadowTeacher":
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShadowTeacherProfile(
                                    userId: userId!,
                                  ),
                                ),
                              );
                              break;
                            default:
                              print("error in category");
                              break;
                          }
                        },
                        //child: ProfileImageDisplay(updateStreamController: updateStreamController,),
                      ),
                      currentAccountPictureSize: const Size.square(75),
                      decoration: const BoxDecoration(
                        color: kDarkBlue,
                      ),
                      onDetailsPressed: () async {
                        switch (category) {
                          case "Parent":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ParentProfile(
                                  userID: userId!,
                                ),
                              ),
                            );
                            break;
                          case "Specialist":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpecialistProfile(
                                        userId: userId!,
                                      )),
                            );
                            break;
                          case "ShadowTeacher":
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShadowTeacherProfile(
                                  userId: userId!,
                                ),
                              ),
                            );
                            break;
                          default:
                            print("error in category");
                            break;
                        }
                      },
                      otherAccountsPicturesSize: const Size.square(45),
                      otherAccountsPictures: [
                        if (category == "Specialist" && isAdmin!)
                            CircularProfileAvatar(
                              '',
                              backgroundColor: kPrimary,
                              borderWidth: 1.0,
                              borderColor: kPrimary.withOpacity(0.5),
                              radius:18,
                              child: CachedNetworkImage(
                                width: mq.size.height * .05,
                                height: mq.size.height * .05,
                                imageUrl: AuthManager.url,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit
                                          .cover, // Set the fit property to cover
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                        child: Icon(CupertinoIcons.person)),
                              ),
                              onTap: () async {
                                if (userId != null) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CenterProfile(
                                        userId: userId,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                      ],
                    ),
                    ListTile(
                      // key:homeKey,
                      leading: Icon(
                        FontAwesomeIcons.house,
                        color: kDarkerColor,
                        size: 22,
                      ),
                      title: const Text(
                        "Home",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                      ),
                    ),
                    ListTile(
                      // key:searchKey,
                      leading: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: kDarkerColor,
                        size: 22,
                      ),
                      title: const Text(
                        "Search",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Search()),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.question,
                        color: kDarkerColor,
                        size: 22,
                      ),
                      title: const Text(
                        "Quiz",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Quiz()));
                      },
                    ),
                    if (category == 'Parent')
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.brain,
                          color: kDarkerColor,
                          size: 22,
                        ),
                        title: const Text(
                          "Spectrum Bot",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        onTap: () async {
                          String n = (await AuthManager.getUserName())!;
                          String ID = (await AuthManager.getUserId())!;
                          final result = Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      SpectrumBot(name: n, id: ID))));
                        },
                      ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.message,
                        color: kDarkerColor,
                        size: 22,
                      ),
                      title: const Text(
                        "contact us",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ContactUs(),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.doorOpen,
                        color: kDarkerColor,
                        size: 22,
                      ),
                      title: const Text(
                        "Log Out",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      onTap: () async {
                        await AuthManager.clearUserData();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      },
                    ),
                    Divider(
                      color: Colors.grey[700],
                      height: 1,
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.trashCan,
                        color: kDarkerColor,
                        size: 22,
                      ),
                      title: const Text(
                        "Destroy account",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      onTap: () async {
                        bool confirmed =
                            await _showDestroyAccountConfirmation(context);
                        if (confirmed) {
                          _destroy(context);
                        }
                      },
                    ),
                    if (category == "Specialist" && isAdmin!)
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.trashCan,
                          color: kDarkerColor,
                          size: 22,
                        ),
                        title: const Text(
                          "Destroy Center account",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        onTap: () async {
                          bool confirmed =
                              await _showDestroyAccountConfirmation(context);
                          if (confirmed) {
                            _destroyCenter(context);
                          }
                        },
                      ),
                  ],
                ),
              ),
              body: body,
            );
          } else {
            // Return a default UI if no data is available
            return const Text('No data available');
          }
        });
  }

  Future<Tuple5<String?, String?, String?, bool?, String?>>
      _getEmailNameAndCategory() async {
    try {
      String? userId = await AuthManager.getUserId();

      // Check if userId is not null before proceeding
      if (userId != null) {
        var email = await AuthManager.getUserEmail();
        var userName = await getUserName(userId);
        var category = await getUserCategory(userId);
        bool isAdmin = await checkAdmin(userId);
        // Return a tuple of email, userName, and category
        return Tuple5(email, userName, category, isAdmin, userId);
      } else {
        return Tuple5(null, null, null, false, null);
      }
    } catch (error) {
      // Handle errors here
      print('Error in _getEmailNameAndCategory: $error');
      return const Tuple5(null, null, null, false, null);
    }
  }

  Future _destroy(BuildContext context) async {
    try {
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        String category = await getUserCategory(userId);
        switch (category) {
          case "Parent":
            deleteParent(userId);
            break;
          case "Specialist":
            deleteSpecialist(userId);
            break;
          case "ShadowTeacher":
            deleteShadowTeacher(userId);
            break;
          default:
            print("error in category");
            return;
        }
        await AuthManager.clearUserData();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } catch (error) {}
  }

  Future _destroyCenter(BuildContext context) async {
    try {
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        deleteCenter(userId);
      }
    } catch (error) {}
  }

  Future<bool> _showDestroyAccountConfirmation(BuildContext context) async {
    return await showDialog<bool>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: kDarkerBlue,
                title:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(
                    Icons.warning_amber,
                    color: kYellow,
                    size: 40,
                  ),
                  Text('Warning',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kPrimary,
                          fontSize: 30)),
                ]),
                content: Text(
                    'Are you sure you want to destroy your account?\nThis action cannot be undone.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 21,
                        color: kPrimary)),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimary,
                          side: BorderSide(width: 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text('Yes',
                          style: TextStyle(
                              color: kDarkerColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17))),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimary,
                          side: BorderSide(width: 1.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text('Cancel',
                          style: TextStyle(
                              color: kDarkerColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17))),
                ],
              );
            }) ??
        false;
  }
}

class CoachmarkDesc extends StatefulWidget {
  const CoachmarkDesc({
    super.key,
    required this.text,
    this.skip = "Skip",
    this.next = "Next",
    this.onSkip,
    this.onNext,
  });

  final String text;
  final String skip;
  final String next;
  final void Function()? onSkip;
  final void Function()? onNext;

  @override
  State<CoachmarkDesc> createState() => _CoachmarkDescState();
}

class _CoachmarkDescState extends State<CoachmarkDesc>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: 20,
      duration: const Duration(milliseconds: 800),
    )..repeat(min: 0, max: 20, reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animationController.value),
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                  color: kDarkerBlue,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: widget.onSkip,
                    child: Text(widget.skip,
                        style: TextStyle(color: kPrimary, fontSize: 15)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kDarkerBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                const SizedBox(width: 16),
                ElevatedButton(
                    onPressed: widget.onNext,
                    child: Text(widget.next,
                        style: TextStyle(
                            color: kPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kDarkerBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
