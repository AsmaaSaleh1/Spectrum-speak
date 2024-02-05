import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/CenterUser.dart';
import 'package:spectrum_speak/modules/Dialogs.dart';
import 'package:spectrum_speak/modules/center.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_center.dart';
import 'package:spectrum_speak/screen/add_specialist_from_center.dart';
import 'package:spectrum_speak/screen/edit_center_profile.dart';
import 'package:spectrum_speak/units/build_date_text_field.dart';
import 'package:spectrum_speak/units/build_text_field.dart';
import 'package:spectrum_speak/units/build_time_text_field.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/custom_clipper.dart';
import 'package:tuple/tuple.dart';

class StackContainerCenter extends StatefulWidget {
  final String userId;
  StackContainerCenter({
    super.key,
    required this.userId,
  });

  @override
  State<StackContainerCenter> createState() => _StackContainerCenterState();
}

class _StackContainerCenterState extends State<StackContainerCenter> {
  String url = '';
  String centerID = '';
  Future<void> assignUrl() async {
    centerID = (await getCenterIdForSpecialist(widget.userId))!;
    CenterUser c = await Utils.fetchCenter(centerID);
    await (url = c.image);
    print('$url');
    setState(() {
      url = url;
    });
  }

  @override
  initState() {
    super.initState();
    assignUrl();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return FutureBuilder<Tuple2<CenterAutism?, String?>>(
        future: _getCenter(),
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
            CenterAutism? center = snapshot.data!.item1;
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
                    alignment: const Alignment(0, 0.8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProfileAvatar(
                          '',
                          borderWidth: 3.0,
                          borderColor: kDarkerBlue,
                          backgroundColor: kPrimary,
                          radius: 80.0,
                          child: CachedNetworkImage(
                            width: mq.size.height * .1,
                            height: mq.size.height * .1,
                            imageUrl: url,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit
                                      .cover, // Set the fit property to cover
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                                    child: Icon(CupertinoIcons.person)),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          toBeginningOfSentenceCase(center?.centerName) ?? "",
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
                                FontAwesomeIcons.locationDot,
                                size: 15.0,
                                color: kRed,
                              ),
                              Text(
                                center!.city,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: widget.userId == userIdLogin,
                              child: CustomButton(
                                foregroundColor: kDarkerColor,
                                backgroundColor: kBlue,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EditCenterProfile(),
                                    ),
                                  );
                                },
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
                            Visibility(
                              visible: widget.userId == userIdLogin,
                              child: CustomButton(
                                foregroundColor: kDarkerColor,
                                backgroundColor: kBlue,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddSpecialistFromCenter(),
                                    ),
                                  );
                                },
                                buttonText: 'Add Specialist',
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  size: 18.0,
                                ),
                                iconColor: kPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                          visible: widget.userId == userIdLogin,
                          child: CustomButton(
                            foregroundColor: kDarkerBlue,
                            backgroundColor: kYellow,
                            onPressed: () {
                              addCenterEvent(context);
                            },
                            buttonText: 'Add Event',
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 18.0,
                            ),
                            iconColor: kDarkerBlue,
                          ),
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

  Future<Tuple2<CenterAutism?, String?>> _getCenter() async {
    try {
      //String? userId = await AuthManager.getUserId();
      print('UserIdd: ${widget.userId}');
      String? userIdLogin = await AuthManager.getUserId();

      // Check if userId is not null before calling profileShadowTeacher
      var result = await profileCenter(widget.userId);
      return Tuple2(result, userIdLogin);
    } catch (error) {
      // Handle errors here
      print('Error in _getCenter: $error');
      return Tuple2(null, null);
    }
  }

  Future<void> addCenterEvent(BuildContext context) async {
    TextEditingController _descriptionController = TextEditingController();
    TextEditingController _dateController = TextEditingController();
    TextEditingController _timeController = TextEditingController();
    // double size = MediaQuery.of(context).size.height * 0.46;
    bool tap=true;
    bool result = false;
    await showDialog(
        barrierColor: kDarkerBlue.withOpacity(0.1),
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
                child: Text('Add Event',
                    style: TextStyle(
                        color: kDarkerBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold))),
            content: Expanded(
              child: Container(
                height:MediaQuery.of(context).size.height * 0.46,
                child: Column(children: [
                  CustomTextField(
                      labelText: "Desciption",
                      placeholder: "Write the event\'s description here",
                      isPasswordTextField: false,
                      numOfLine: 3,
                      controller: _descriptionController,
                      onTap: () {
                        setState(() {
                          tap=false;
                        });
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  BuildDateTextField(
                    labelText: 'Event Date',
                    placeholder: '2024-01-31',
                    controller: _dateController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  BuildTimeTextField(
                      labelText: "Event Time",
                      placeholder: "9:00 PM",
                      controller: _timeController)
                ]),
              ),
            ),
            // if(tap==true)
            actions: [
              // if(tap)
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkerBlue,
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text('Cancel',
                      style: TextStyle(
                          color: kPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 17))),
              // if(tap)
              TextButton(
                  onPressed: () async {
                    print(_descriptionController.text);
                    print(_dateController.text);
                    print(_timeController.text);
                    result = await addEvent(
                        centerID,
                        _descriptionController.text,
                        '${_dateController.text} ${_timeController.text}:00');
                    if (result) {
                      Navigator.pop(context);
                      Dialogs.showSnackbar(
                          context, "Event has been added successfully");
                    } else {
                      Dialogs.showSnackbar(context,
                          "You have a scheduled event at this date and time, please pick a different data or time.");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kDarkerBlue,
                      side: BorderSide(width: 1.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text('Add',
                      style: TextStyle(
                          color: kPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 17))),
            ],
          );
        });
  }
}
