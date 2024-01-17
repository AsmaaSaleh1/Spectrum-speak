import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_admin.dart';
import 'package:spectrum_speak/units/build_search_text_field.dart';
import 'package:spectrum_speak/widgets/card_admin.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

class AddRemoveAdmin extends StatefulWidget {
  const AddRemoveAdmin({super.key});

  @override
  State<AddRemoveAdmin> createState() => _AddRemoveAdminState();
}

class _AddRemoveAdminState extends State<AddRemoveAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBar(
        body: AddRemoveAdminCall(),
      ),
    );
  }
}

class AddRemoveAdminCall extends StatefulWidget {
  const AddRemoveAdminCall({super.key});

  @override
  State<AddRemoveAdminCall> createState() => _AddRemoveAdminCallState();
}

class _AddRemoveAdminCallState extends State<AddRemoveAdminCall> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> usersData = [];

  Future<void> getUsers(String namePrefix) async {
    try {
      var data = await searchToUsers(namePrefix);

      setState(() {
        usersData = data;
      });
    } catch (error) {
      print('Error fetching users data: $error');
    }
  }
  @override
  void initState() {
    super.initState();
    getUsers('');
  }

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
              CustomSearchTextField(
                labelText: 'Search',
                placeholder: 'Search',
                controller: _searchController,
                onTextChanged: (text) {
                  getUsers(text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (usersData.isNotEmpty)
                Column(
                  children: usersData.map((data) {
                    return CardAdmin(
                      userID: data['UserID'].toString(),
                      userName: data['Username'] ?? '',
                      userCategory: data['Category'] ?? '',
                    );
                  }).toList(),
                )
              else
                Center(
                  child: Text(
                    "No User Found",
                    style: TextStyle(
                      color: kDarkerColor.withOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
