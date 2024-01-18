import 'dart:async';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/CenterNotification.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/rest/rest_api_menu.dart';
import 'package:spectrum_speak/rest/rest_api_profile_delete.dart';
import 'package:spectrum_speak/screen/center_profile.dart';
import 'package:spectrum_speak/screen/contact_us.dart';
import 'package:spectrum_speak/screen/login.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/screen/search_page.dart';
import 'package:spectrum_speak/screen/shadow_teacher_profile.dart';
import 'package:spectrum_speak/screen/specialist_profile.dart';
import 'package:spectrum_speak/screen/splash_screen_chat.dart';
import 'package:tuple/tuple.dart';

import 'card_user_chat.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          CupertinoIcons.list_bullet,
          color: kPrimary,
          size: 30,
        ),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            _showPopupMenu(context, 5);
          },
          icon: const Icon(
            CupertinoIcons.envelope_open,
            color: kPrimary,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {
            print('Calendar button pressed');
          },
          icon: const Icon(
            CupertinoIcons.calendar,
            color: kPrimary,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {
            print('Notification button pressed');
            CenterNotification cn = CenterNotification(
                fromID: "1",
                time: "time",
                toID: "4",
                read: false,
                type: "request",
                value: false);
            Utils.storeCenterNotification(cn);
          },
          icon: const Icon(
            CupertinoIcons.bell,
            color: kPrimary,
            size: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProfileAvatar(
            '',
            borderWidth: 1.0,
            borderColor: kPrimary.withOpacity(0.5),
            radius: 20.0,
            backgroundColor: kPrimary,
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TopBar extends StatelessWidget {
  final Widget body;

  TopBar({
    super.key,
    required this.body,
  });
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: kPrimary,
                        child: CircularProfileAvatar(
                          '',
                          borderWidth: 1.0,
                          borderColor: kPrimary.withOpacity(0.5),
                          radius: 90.0,
                          backgroundColor: kPrimary,
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
                          Container(
                            width: 90.0,
                            height: 90.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimary.withOpacity(0.5),
                                width: 1.0,
                              ),
                              color: kPrimary,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  0.0), // Set borderRadius to 0.0
                              child: CircularProfileAvatar(
                                '',
                                backgroundColor: kPrimary,
                                borderWidth: 1.0,
                                borderColor: kPrimary.withOpacity(0.5),
                                onTap: () async {
                                  if (userId != null) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => CenterProfile(
                                          userId: userId,
                                        ),
                                      ),
                                    );
                                  } else {
                                    print('userId null');
                                  }
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                    ListTile(
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
                      onTap: () {},
                    ),
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
                      onTap: () {},
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
        print('UserId is null');
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
      } else {
        print('UserId is null');
      }
    } catch (error) {}
  }

  Future _destroyCenter(BuildContext context) async {
    try {
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        deleteCenter(userId);
      } else {
        print('UserId is null');
      }
    } catch (error) {}
  }

  Future<bool> _showDestroyAccountConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Warning"),
              content: Text("Are you sure you want to destroy your account?"
                  "This action cannot be undone."),
              icon: Icon(
                Icons.warning_amber,
                size: 45,
                color: kYellow,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Close the dialog and return false
                  },
                ),
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // Close the dialog and return true
                  },
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the user dismisses the dialog without making a choice
  }
}

void _showPopupMenu(BuildContext context, int numberOfCards) async {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;
  Utils.getMyUsersIDsTopBar();
  Utils.getAllUserssTopBar(Utils.firstList);
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
              for (int i = 0; i < Utils.secondList.length; i++)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: CardUserChat(user: Utils.secondList[i]),
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
                    'Show All Messages',
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
