import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // Hide the default leading back button
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: (){},
            icon: const Icon(FontAwesomeIcons.chevronLeft,size: 20,),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(FontAwesomeIcons.bars,size: 20,),
          ),
        ],
      ),
      elevation: 0.0,
    );
  }
}