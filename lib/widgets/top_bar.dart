import 'package:flutter/material.dart';

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
            icon: const Icon(Icons.arrow_back,),
          ),
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.menu,),
          ),
        ],
      ),
      elevation: 0.0,
    );
  }
}