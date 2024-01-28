import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_admin.dart';
import 'package:spectrum_speak/rest/rest_api_menu.dart';
import 'package:spectrum_speak/rest/rest_api_profile_delete.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/screen/shadow_teacher_profile.dart';
import 'package:spectrum_speak/screen/specialist_profile.dart';
import 'package:mailer/mailer.dart';

class CardUserToBlock extends StatefulWidget {
  final String userID;
  final String userName;
  final String userCategory;
  final VoidCallback? onBlockPressed;
  const CardUserToBlock({
    super.key,
    required this.userID,
    required this.userName,
    required this.userCategory, this.onBlockPressed,
  });

  @override
  State<CardUserToBlock> createState() => _CardUserToBlockState();
}

class _CardUserToBlockState extends State<CardUserToBlock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: kDarkerColor,
      color: kPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          switch (widget.userCategory) {
            case "Parent":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ParentProfile(
                    userID: widget.userID,
                  ),
                ),
              );
              break;
            case "Specialist":
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SpecialistProfile(
                          userId: widget.userID,
                        )),
              );
              break;
            case "ShadowTeacher":
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShadowTeacherProfile(
                    userId: widget.userID,
                  ),
                ),
              );
              break;
            default:
              print("error in category");
              break;
          }
        },
        child: ListTile(
          leading: CircularProfileAvatar(
            '',
            borderWidth: 1.0,
            borderColor: kDarkerColor,
            backgroundColor: kPrimary,
            radius: 25.0,
            child: Image.asset(
              'images/prof.png',
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            widget.userName,
            style: TextStyle(
              color: kDarkerColor,
            ),
          ),
          subtitle: Text(
            widget.userCategory,
            maxLines: 1,
          ),
          trailing: ElevatedButton.icon(
            onPressed: () async {
              bool confirmed = await _showDestroyAccountConfirmation(
                context,
              );
              String email = await getEmailByID(
                widget.userID,
              );
              if (confirmed) {
                switch (widget.userCategory) {
                  case "Parent":
                  case "Specialist":
                  case "ShadowTeacher":
                    blockUser(
                      widget.userID,
                    );
                    sendEmail(
                      email,
                      widget.userName,
                    );
                    widget.onBlockPressed!();
                    break;
                  default:
                    print("error in category");
                    return;
                }
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: kPrimary,
              backgroundColor: kBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  7,
                ),
              ),
            ),
            icon: Icon(
              FontAwesomeIcons.userSlash,
              color: kPrimary,
              size: 17,
            ),
            label: Text(
              "Block",
              style: TextStyle(
                color: kPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showDestroyAccountConfirmation(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Warning"),
              content: Text("Are you sure you want to destroy this account?"
                  "This action cannot be undone."),
              icon: Icon(
                Icons.warning_amber,
                size: 45,
                color: kYellow,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Close the dialog and return false
                  },
                ),
                TextButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // Close the dialog and return true
                  },
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the user dismisses the dialog without making a choice
  }

  Future<void> sendEmail(String userEmail, String userName) async {
    // Configure your email server and credentials
    final smtpServer = gmail('asmaatareq1999@Gmail.com', 'evqbiqbqqezaefvl');

    // Create a message
    final message = Message()
      ..from = Address('asmaatareq1999@gmail.com', 'Spectrum Speak Application')
      ..recipients.add('$userEmail')
      ..subject = 'Account Deleting'
      ..text = 'Dear $userName \n\n'
          'I hope this email finds you well. We regret to inform you that your account on the Spectrum Speak App is scheduled for deletion. After a thorough review, we have observed frequent complaints against your account or instances of misuse of the app.\n\n'
          'If you believe this decision is in error or would like to discuss further, please contact our support team at [SpectrumSpeak@gmail.com] within the next 5 days.\n\n'
          'Thank you for your understanding.\n\nBest regards,\n\nSpectrum Speak App Team';
    try {
      // Send the email
      final sendReport = await send(message, smtpServer);

      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
