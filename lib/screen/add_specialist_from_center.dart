import 'package:flutter/material.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class AddSpecialistFromCenter extends StatefulWidget {
  const AddSpecialistFromCenter({super.key});

  @override
  State<AddSpecialistFromCenter> createState() =>
      _AddSpecialistFromCenterState();
}

class _AddSpecialistFromCenterState extends State<AddSpecialistFromCenter> {
  final TextEditingController _searchController = TextEditingController();
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
                  CustomTextField(
                    labelText: 'Search',
                    placeholder: 'Search',
                    isPasswordTextField: false,
                    controller: _searchController,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
