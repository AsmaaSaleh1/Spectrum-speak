import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/modules/Dialogs.dart';
import 'package:spectrum_speak/modules/child.dart';
import 'package:spectrum_speak/modules/specialist.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_booking.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/screen/center_profile.dart';
import 'package:spectrum_speak/screen/search_page.dart';
import 'package:spectrum_speak/screen/sign_up_center.dart';
import 'package:spectrum_speak/screen/sign_up_specialist.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/custom_clipper.dart';
import 'package:tuple/tuple.dart';

class StackContainerSpecialist extends StatelessWidget {
  final String userId;
  final String category;
  const StackContainerSpecialist({
    super.key,
    required this.userId,
    required this.category,
  });
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tuple2<Specialist?, String?>>(
        future: _getSpecialist(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // You can return a loading indicator here if needed
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
            // Handle the error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Build your UI with the fetched data
            Specialist specialist = snapshot.data!.item1!;
            String userIdLogin = snapshot.data!.item2!;
            return SizedBox(
              height: 400.0,
              child: Stack(
                children: <Widget>[
                  Container(),
                  ClipPath(
                    clipper: MyCustomClipper(),
                    child: Container(
                      height: 300.0,
                      color: kDarkBlue,
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, 1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProfileAvatar(
                          '',
                          borderWidth: 4.0,
                          borderColor: kPrimary,
                          radius: 80.0,
                          //child: ProfileImageDisplay(),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          toBeginningOfSentenceCase(specialist.userName) ?? "",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkerColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                FontAwesomeIcons.userDoctor,
                                size: 15.0,
                                color: kGreen,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                toBeginningOfSentenceCase(
                                        specialist.specialistCategory) ??
                                    "",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                FontAwesomeIcons.locationDot,
                                size: 15.0,
                                color: kRed,
                              ),
                              Text(
                                specialist.city,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: category == 'Parent',
                              child: CustomButton(
                                foregroundColor: kDarkerColor,
                                backgroundColor: kBlue,
                                onPressed: () {
                                  _bookSessionButtonPressed(context,specialist);
                                },
                                buttonText: 'Book a session',
                                icon: const Icon(
                                  Icons.calendar_month,
                                  color: kRed,
                                  size: 18.0,
                                ),
                                iconColor: kPrimary,
                              ),
                            ),
                            Visibility(
                              visible: userId == userIdLogin,
                              child: CustomButton(
                                foregroundColor: kDarkerColor,
                                backgroundColor: kBlue,
                                onPressed: () {},
                                buttonText: 'Edit Profile',
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18.0,
                                ),
                                iconColor: kPrimary,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            if (specialist.specialistCategory ==
                                'Rehabilitation')
                              Visibility(
                                visible: userId ==
                                    userIdLogin, // Show only if userId equals userIdLogin
                                child: specialist.admin
                                    ? CustomButton(
                                        foregroundColor: kDarkerColor,
                                        backgroundColor: kYellow,
                                        onPressed: () async {
                                          String? userId =
                                              await AuthManager.getUserId();
                                          if (userId != null) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CenterProfile(
                                                  userId: userId,
                                                ),
                                              ),
                                            );
                                          } else {
                                            print('userId null');
                                          }
                                        },
                                        buttonText: 'Go to Center',
                                        icon: const Icon(
                                          Icons.home_work_outlined,
                                          size: 18.0,
                                        ),
                                        iconColor: kPrimary,
                                      )
                                    : CustomButton(
                                        foregroundColor: kDarkerColor,
                                        backgroundColor: kGreen,
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpCenter(
                                                SpecialistID:
                                                    specialist.specialistID,
                                                userId: userId,
                                              ),
                                            ),
                                          );
                                        },
                                        buttonText: 'Make Center',
                                        icon: const Icon(
                                          Icons.login,
                                          size: 18.0,
                                        ),
                                        iconColor: kPrimary,
                                      ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Return a default UI if no data is available
            return const Text('No data available');
          }
        });
  }

  Future<void> _showDateTimePickerDialog(BuildContext context,Specialist specialist) async {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    // Show Date Picker
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (pickedDate != null) {
      // Show Time Picker
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        // Combine selected date and time
        selectedDate = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Retrieve the list of children
        List<Child> loadedChildren =
            await childCard(AuthManager.u.UserID.toString());

        // Show dialog to select a child
        Child? selectedChild = await showDialog<Child>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Select a Child'),
              content: SingleChildScrollView(
                child: Column(
                  children: loadedChildren.map((child) {
                    return ListTile(
                      title: Text(child.childName),
                      onTap: () {
                        Navigator.pop(context, child);
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );

        if (selectedChild != null) {
          // TODO: Handle the selected date, time, and child as needed
          print('Selected Date and Time: $selectedDate');
          print('Selected Child: ${selectedChild.childName}');
          String availability =
              await checkBooking(userId,AuthManager.u.UserID.toString(), selectedDate.toString());
          if (availability=='Parent Unavailable') {
            Dialogs.showSnackbar(context, 'You have a session at the requested time, please pick a different date and time slot');
          }
          else if(availability=='Specialist Unavailable'){
            Dialogs.showSnackbar(context,
                'Unable to book the session. Specialist is unavailable at the requested time, please pick a different date and time slot');
          }
          else {
            await addBooking(AuthManager.u.UserID.toString(),selectedChild!.childID,userId,'${specialist.specialistCategory}',selectedDate.toString());
            Dialogs.showSnackbar(context,
                "Session for ${selectedChild!.childName} has been booked successfully}");
            Navigator.push(context,MaterialPageRoute(builder: ((context) => Search())));
          }
          // TODO: Implement the logic to book a session with the selected date, time, and child
        }
      }
    }
  }

// Call this function when the "Book a session" button is pressed
  void _bookSessionButtonPressed(BuildContext context,Specialist specialist) {
    // Show the date, time, and child selection dialog
    _showDateTimePickerDialog(context,specialist);
  }

  Future<Tuple2<Specialist?, String?>> _getSpecialist(
      BuildContext context) async {
    try {
      // Check if userId is not null before calling profileSpecialist
      var result = await profileSpecialist(userId);
      String? userIdLogin = await AuthManager.getUserId();

      // Check if result is null or if specialist sign-up is not complete
      if (result == null) {
        var check = await checkSpecialistSignUpComplete(userId);
        if (!check!) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpSpecialist(),
            ),
          );
        } else {
          print("error in checker specialist");
        }
      }

      return Tuple2(result, userIdLogin);
    } catch (error) {
      // Handle errors here
      print('Error in _getSpecialist: $error');
      return Tuple2(null, null);
    }
  }
}
