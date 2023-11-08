import 'package:flutter/material.dart';
import 'package:spectrum_speak/widgets/card_specialist.dart';
import 'package:spectrum_speak/widgets/card_center.dart';
import 'package:spectrum_speak/widgets/card_item.dart';

import '../const.dart';
import '../units/build_radio_button.dart';

class Centers extends StatefulWidget {
  const Centers({Key? key}) : super(key: key);

  @override
  State<Centers> createState() => _CentersState();
}

class _CentersState extends State<Centers> {
  Search selectedSearch = Search.center;

  void onSearchTypeChanged(Search newValue) {
    setState(() {
      selectedSearch = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> cardColors = [kBlue, kRed, kGreen, kYellow,kBlue, kRed, kGreen, kYellow,kBlue, kRed, kGreen, kYellow];
    List<Widget> cards = [];

    for (Color color in cardColors) {
      if (selectedSearch == Search.specialist) {
        cards.add(CardSpecialist(cardColor: color));
      } else if (selectedSearch == Search.center) {
        cards.add(CenterCard(cardColor: color));
      }
    }
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
                    "Search",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: kDarkerColor,
                    ),
                  ),
                ),
              ),
              RadioButtonSearch(
                selectedSearch: selectedSearch,
                onSearchTypeChanged: onSearchTypeChanged,
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
              Center(
                child: Wrap(
                  spacing: 50.0, // Horizontal spacing between items
                  runSpacing: 30.0, // Vertical spacing between lines
                  children: cards, // Use the list of cards here
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}