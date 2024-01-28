import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/modules/ChatUser.dart';
import 'package:spectrum_speak/modules/parent.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';
import 'package:spectrum_speak/screen/edit_profile.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:spectrum_speak/units/custom_clipper.dart';
import 'package:tuple/tuple.dart';

class StackContainerParent extends StatelessWidget {
  final String userID;
  StackContainerParent({super.key, required this.userID});
  @override
  String? url = '';
  Widget build(BuildContext context) {
    assignUrl();
    MediaQueryData mq = MediaQuery.of(context);
    return FutureBuilder<Tuple2<Parent?, String?>>(
        future: _getParent(userID),
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
            Parent? parent = snapshot.data!.item1;
            String? userIdLogin = snapshot.data!.item2;
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
                          borderWidth: 3.0,
                          borderColor: kDarkerBlue,
                          backgroundColor: kPrimary,
                          radius: 80.0,
                          child: CachedNetworkImage(
                            width: mq.size.height * .05,
                            height: mq.size.height * .05,
                            imageUrl: url!,
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
                        const SizedBox(height: 4.0),
                        Text(
                          toBeginningOfSentenceCase(parent?.userName) ?? "",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: kDarkerColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            parent!.category.toString().split('.').last.trim(),
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey[700],
                            ),
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
                                parent.city,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Visibility(
                          visible: userID ==
                              userIdLogin, // Show only if userId equals userIdLogin
                          child: CustomButton(
                            foregroundColor: kDarkerColor,
                            backgroundColor: kBlue,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfile()),
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

  Future<Tuple2<Parent?, String?>> _getParent(String userId) async {
    try {
      // Check if userId is not null before calling profileShadowTeacher
      var result = await profileParent(userId);
      String? userIdLogin = await AuthManager.getUserId();
      return Tuple2(result, userIdLogin);
    } catch (error) {
      // Handle errors here
      print('Error in _getParent: $error');
      return Tuple2(null, null);
    }
  }

  Future<void> assignUrl() async {
    ChatUser u = await Utils.fetchUser(userID);
    url = u.image;
  }
}
