import 'package:flutter/material.dart';
import 'package:spectrum_speak/const.dart';
import '../widgets/card_item.dart';
import '../widgets/stack_container_parent.dart';
import '../widgets/parent_information.dart';

class ParentProfile extends StatefulWidget {
  const ParentProfile({Key? key}) : super(key: key);

  @override
  State<ParentProfile> createState() => _ParentProfileState();
}

class _ParentProfileState extends State<ParentProfile> {
  @override
  Widget build(BuildContext context) => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        double linePadding;
        if (screenWidth >= 1200) {
          linePadding = 110;
        } else if (screenWidth >= 800) {
          linePadding = 70;
        } else {
          linePadding = 20;
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const StackContainerParent(),
                const ParentInformation(),
                Divider(
                  color: kDarkerColor, // You can customize the color
                  thickness: 2.0, // You can customize the thickness
                  indent: linePadding,
                  endIndent: linePadding,
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Text(
                    "My Children",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: kDarkerColor,
                    ),
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      CardItem(),
                      CardItem(),
                      // Add more CardItems as needed
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
