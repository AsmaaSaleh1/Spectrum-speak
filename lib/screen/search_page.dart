import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/build_tab.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchEnum selectedSearch = SearchEnum.center;

  void onSearchTypeChanged(SearchEnum newValue) {
    setState(() {
      selectedSearch = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TopBar(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.magnifyingGlass,
                            size: 40.0,
                            color: kDarkBlue,
                          ),
                          const SizedBox(width: 20,),
                          Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: kDarkerColor,
                            ),
                          ),
                        ],
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
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: MyTab(
                        selectedSearch: selectedSearch
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Add the gradient at the bottom of the stack
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80, // Adjust the height as needed
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [kPrimary.withOpacity(0.8),kPrimary.withOpacity(0.5),kPrimary.withOpacity(0.1),kPrimary.withOpacity(0.0)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
