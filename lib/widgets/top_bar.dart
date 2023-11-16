import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/const.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/screen/search_page.dart';

class TopBar extends StatelessWidget {
  final Widget body;

  const TopBar({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.list_bullet, // Change this icon to the one you prefer
            color: kPrimary,
            size: 30,
          ),
          onPressed: () {
            // Handle drawer opening
            scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Handle the message button press
              print('Message button pressed');
            },
            icon: const Icon(
              CupertinoIcons.envelope_open,
              color: kPrimary,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {
              // Handle the calendar button press
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
              // Handle the notification button press
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
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ParentProfile()),
                );
              },
              child: Image.asset('images/prof.png'),
            ),
          )
        ],
      ),
      drawer: Drawer(
        shadowColor: kDarkerColor,
        backgroundColor: kPrimary,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                "User Name",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
              ),
              accountEmail: const Text(
                "email@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
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
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ParentProfile()),
                    );
                  },
                  child: Image.asset('images/prof.png'),
                ),
              ),
              currentAccountPictureSize: const Size.square(75),
              decoration: const BoxDecoration(
                color: kDarkBlue,
              ),
              onDetailsPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ParentProfile()),
              ),
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
                "Exit",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
