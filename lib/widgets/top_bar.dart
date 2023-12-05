import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api.dart';
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
  const CustomAppBar({super.key});
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
          Scaffold.of(context).openDrawer();
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
                    MaterialPageRoute(builder: (context) => const ParentProfile()),
                  );
                  break;
                case "Specialist":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SpecialistProfile()),
                  );
                  break;
                case "ShadowTeacher":
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ShadowTeacherProfile()),
                  );
                  break;
                default:
                  print("error in category");
                  break;
              }
            },
            child: Image.asset('images/prof.png'),
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

  const TopBar({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tuple2<String?, String?>>(
        future: _getEmailAndName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // You can return a loading indicator here if needed
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle the error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Access the data from the tuple
            String? email = snapshot.data!.item1;
            String? userName = snapshot.data!.item2;
            return Scaffold(
              appBar: const CustomAppBar(),
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
                            String? userId = await AuthManager.getUserId();
                            String category = await getUserCategory(userId!);
                            switch (category) {
                              case "Parent":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ParentProfile()),
                                );
                                break;
                              case "Specialist":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SpecialistProfile()),
                                );
                                break;
                              case "ShadowTeacher":
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ShadowTeacherProfile()),
                                );
                                break;
                              default:
                                print("error in category");
                                break;
                            }
                          },
                          child: Image.asset('images/prof.png'),
                        ),
                      ),
                      currentAccountPictureSize: const Size.square(75),
                      decoration: const BoxDecoration(
                        color: kDarkBlue,
                      ),
                      onDetailsPressed: () async {
                        String? userId = await AuthManager.getUserId();
                        String category = await getUserCategory(userId!);
                        switch (category) {
                          case "Parent":
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ParentProfile()),
                            );
                            break;
                          case "Specialist":
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SpecialistProfile()),
                            );
                            break;
                          case "ShadowTeacher":
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ShadowTeacherProfile()),
                            );
                            break;
                          default:
                            print("error in category");
                            break;
                        }
                      },
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
                        MaterialPageRoute(builder: (context) => const MainPage()),
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
                        FontAwesomeIcons.message,
                        color: kDarkerColor,
                        size: 22,
                      ),
                      title: const Text(
                        "AI chat",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      onTap: () {},
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
                      onTap: () async{
                        await AuthManager.clearUserData();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Login()));
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
  Future<Tuple2<String?, String?>> _getEmailAndName() async {
    try {
      String? userId = await AuthManager.getUserId();
      print('UserId: $userId');

      // Check if userId is not null before calling profileShadowTeacher
      if (userId != null) {
        var email = await AuthManager.getUserEmail();
        var userName = await getUserName(userId);
        print('email and userName result: $email $userName');

        // Return a tuple of email and userName
        return Tuple2(email, userName);
      } else {
        print('UserId is null');
        return const Tuple2(null, null);
      }
    } catch (error) {
      // Handle errors here
      print('Error in _getShadowTeacher: $error');
      return const Tuple2(null, null);
    }
  }

}

void _showPopupMenu(BuildContext context, int numberOfCards) async {
  final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

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
              for (int i = 0; i < numberOfCards; i++)
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: CardUserChat(),
                ),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SplashChatScreen()),
                    );
                  },
                  child: Text(
                      'Show All Messages',
                    style: TextStyle(
                      color: kDarkerColor,
                      fontWeight: FontWeight.bold
                    ),
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