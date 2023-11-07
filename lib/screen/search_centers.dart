import 'package:flutter/material.dart';
import 'package:spectrum_speak/widgets/card_center.dart';
import 'package:spectrum_speak/widgets/card_item.dart';

import '../const.dart';

class Centers extends StatefulWidget {
  const Centers({super.key});

  @override
  State<Centers> createState() => _CentersState();
}

class _CentersState extends State<Centers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 40),
                  child: Text(
                    "Rehabilitation centres",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: kDarkerColor,
                    ),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.only(
                    bottom: 10,
                    left: 8,
                  ),
                  labelText: "Search",
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: kDarkerColor,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "eg: Al-Amal center",
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: Colors.grey.shade700,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      color: kDarkerColor,
                    ),
                  ),
                ),
              ),
              // const CenterCard(),
              // const CenterCard(),
              const Center(
                child: Wrap(
                  spacing: 50.0, // Horizontal spacing between items
                  runSpacing: 30.0, // Vertical spacing between lines
                  children: <Widget>[
                    CenterCard(cardColor: kBlue),
                    CenterCard(cardColor: kRed),
                    CenterCard(cardColor: kGreen),
                    CenterCard(cardColor: kYellow),
                    CenterCard(cardColor: kBlue),
                    CenterCard(cardColor: kRed),
                    CenterCard(cardColor: kGreen),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
