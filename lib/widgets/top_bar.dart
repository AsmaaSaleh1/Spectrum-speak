import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/screen/main_page.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/screen/search_page.dart';
import 'package:spectrum_speak/screen/splash_screen_chat.dart';

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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ParentProfile()),
              );
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
    return Scaffold(
      appBar: const CustomAppBar(),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ParentProfile()),
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