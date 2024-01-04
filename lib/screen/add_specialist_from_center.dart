import 'package:flutter/material.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';
//does not work
class AddSpecialistFromCenter extends StatefulWidget {
  const AddSpecialistFromCenter({super.key});

  @override
  State<AddSpecialistFromCenter> createState() =>
      _AddSpecialistFromCenterState();
}

class _AddSpecialistFromCenterState extends State<AddSpecialistFromCenter> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> specialistData = []; // Assuming your specialist data is a list

  // Define an async function to fetch specialist data
  Future<void> getSpecialists() async {
    try {
      var data = await searchSpecialist();

      if (data is List) {
        setState(() {
          specialistData = data;
        });
      } else {
        print('Error: Invalid data format');
      }
    } catch (error) {
      print('Error fetching specialist data: $error');
    }
  }


  @override
  void initState() {
    super.initState();
    // Fetch specialist data when the page is first created
    getSpecialists();
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
