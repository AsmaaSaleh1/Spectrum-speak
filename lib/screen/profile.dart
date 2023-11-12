import 'package:flutter/material.dart';
import '../widgets/card_item.dart';
import '../widgets/stack_container.dart';
import '../widgets/parent_information.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StackContainer(),
            InformationCard(),
            SingleChildScrollView(
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
  }
}
