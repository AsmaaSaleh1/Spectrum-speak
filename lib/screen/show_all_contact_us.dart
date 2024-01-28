import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/ContactUs.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_contact.dart';
import 'package:spectrum_speak/widgets/card_contact_admin.dart';
import 'package:spectrum_speak/widgets/top_bar.dart';

import 'login.dart';

class ContactUsAdmin extends StatefulWidget {
  const ContactUsAdmin({super.key});

  @override
  State<ContactUsAdmin> createState() => _ContactUsAdminState();
}

class _ContactUsAdminState extends State<ContactUsAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TopBar(
        body: ContactUsAdminCall(),
      ),
    );
  }
}

class ContactUsAdminCall extends StatefulWidget {
  const ContactUsAdminCall({super.key});

  @override
  State<ContactUsAdminCall> createState() => _ContactUsAdminCallState();
}

class _ContactUsAdminCallState extends State<ContactUsAdminCall> {
  List<Contact> contact = [];
  Future getData() async {
    try {
      var con = await getContact();
      setState(() {
        contact = con!;
      });
    } catch (e) {
      print("Error in getData class ContactUsAdmin page: $e");
    }
  }

  Future<List<Widget>?> getContactWidgets() async {
    return contact
        .map(
          (contact) => CardContactUsAdmin(
            contact: contact,
            onDonePressed: getData,
          ),
        )
        .toList();
  }

  // Method to check if the user is logged in
  Future<void> checkLoginStatus() async {
    bool isLoggedIn = await AuthManager.isUserLoggedIn();

    if (!isLoggedIn) {
      // If the user is not logged in, navigate to the login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.zero, // No padding
                        margin: EdgeInsets.zero, // No margin
                        child: Image.asset(
                          'images/contact.png',
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Contact US",
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: kDarkerColor,
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List<Widget>?>(
                    future: getContactWidgets(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          color: kPrimary,
                          child: Container(
                            alignment: Alignment.center,
                            child: const CircularProgressIndicator(
                              backgroundColor: kDarkBlue,
                              color: kDarkBlue,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Stack(
                          children: [
                            Visibility(
                              visible: snapshot.data != null ||
                                  snapshot.data!.isNotEmpty,
                              child: Column(
                                children: snapshot.data ??
                                    [], // Provide a default value when null
                              ),
                            ),
                            Visibility(
                              visible: snapshot.data == null ||
                                  snapshot.data!.isEmpty,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "No Contact Available Until Now",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: kBlue,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(height: 70,),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
