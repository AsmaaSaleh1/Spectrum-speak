import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/units/build_search_text_field.dart';
import 'package:spectrum_speak/widgets/card_choose_specialist.dart';

class AddSpecialistFromCenter extends StatefulWidget {
  const AddSpecialistFromCenter({Key? key}) : super(key: key);

  @override
  State<AddSpecialistFromCenter> createState() =>
      _AddSpecialistFromCenterState();
}

class _AddSpecialistFromCenterState extends State<AddSpecialistFromCenter> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> specialistData = [];

  Future<void> getSpecialists(String namePrefix) async {
    try {
      var data = await searchToAddSpecialist(namePrefix);

      setState(() {
        specialistData = data;
      });
    } catch (error) {
      print('Error fetching specialist data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getSpecialists('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Specialist to Center'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchTextField(
                labelText: 'Search',
                placeholder: 'Search',
                controller: _searchController,
                onTextChanged: (text) {
                  getSpecialists(text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (specialistData.isNotEmpty)
                Column(
                  children: specialistData.map((data) {
                    return CardChooseSpecialist(
                      userID: data['UserID'].toString(),
                      userName: data['Username'] ?? '',
                      specialistCategory: data['SpecialistCategory'] ?? '',
                    );
                  }).toList(),
                )
              else
                Center(
                    child: Text(
                  "No Specialist Found",
                  style: TextStyle(
                    color: kDarkerColor.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }
}
