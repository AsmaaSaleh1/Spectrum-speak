import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/const.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "SPECTRUM SPEAK",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kPrimary,
            ),
          ),
        ),
      ),
      drawer: Drawer(
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
                child: ClipOval(
                  child: Image.asset(
                    'images/prof.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
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
                FontAwesomeIcons.user,
                color: kDarkerColor,
                size: 22,
              ),
              title: const Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ParentProfile()),
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
