import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_rate.dart';
import 'package:spectrum_speak/screen/center_profile.dart';
import 'package:spectrum_speak/widgets/smooth_star_rating.dart';

import '../screen/specialist_profile.dart';
import 'build_text_field.dart';
import 'custom_button.dart';

class AddReview extends StatefulWidget {
  final String image, name, specialistID, centerID, ID;
  final bool isCenter;
  final double userRating;
  final Function(double val) onRating;
  const AddReview({
    super.key,
    required this.image,
    required this.name,
    required this.userRating,
    required this.onRating,
    required this.specialistID,
    required this.centerID,
    required this.isCenter,
    required this.ID,
  });

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        var now = DateTime.now();
        var formatter = DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(now);
        double screenWidth = constraints.maxWidth;
        EdgeInsets contentPadding;
        if (screenWidth >= 1200) {
          contentPadding =
              const EdgeInsets.symmetric(vertical: 20, horizontal: 110.0);
        } else if (screenWidth >= 800) {
          contentPadding =
              const EdgeInsets.symmetric(vertical: 20, horizontal: 70.0);
        } else {
          contentPadding =
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20.0);
        }
        return Padding(
          padding: contentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Rate this app",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: kDarkerColor,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "Tell others what you think",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: kDarkerColor.withOpacity(0.6),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 7, right: 13, bottom: 7),
                    child: CircularProfileAvatar(
                      '',
                      borderWidth: 2.0,
                      borderColor: kDarkerColor.withOpacity(0.7),
                      radius: 27.0,
                      child: Image.asset(widget.image),
                    ),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      color: kDarkerColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SmoothStarRating(
                starCount: 5,
                allowHalfRating: true,
                rating: widget.userRating,
                borderColor: kRed,
                color: kYellow,
                size: 28,
                onRatingChanged: widget.onRating,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: kDarkerColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                preIcon: null,
                labelText: "Comment",
                placeholder: "They were cooperative and kind",
                isPasswordTextField: false,
                controller: _commentController,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews are public and include your account",
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: kDarkerColor.withOpacity(0.6),
                    ),
                  ),
                  CustomButton(
                    foregroundColor: kDarkerColor,
                    backgroundColor: kPrimary,
                    onPressed: () {
                      if (_commentController.text.isEmpty) {
                        return;
                      }
                      doSaveReview(
                        context,
                        widget.userRating,
                        formattedDate,
                        _commentController.text,
                        widget.specialistID,
                        widget.centerID,
                        widget.isCenter,
                        widget.ID,
                      );
                    },
                    buttonText: 'Save',
                    icon: const Icon(
                      Icons.save,
                      size: 18.0,
                    ),
                    iconColor: kGreen,
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

doSaveReview(
  BuildContext context,
  double rate,
  String date,
  String comment,
  String specialistID,
  String centerID,
  bool isCenter,
  String ID,
) async {
  String? loginID = await AuthManager.getUserId();
  var rest = await addRate(
    loginID!,
    rate,
    date,
    comment,
    specialistID,
    centerID,
  );
  if (rest['success']) {
    if (isCenter) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CenterProfile(userId: ID),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => SpecialistProfile(userId: ID),
        ),
      );
    }
    print("correct");
  } else {
    print("error to add rate");
  }
}
