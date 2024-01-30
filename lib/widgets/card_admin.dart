import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/rest/rest_api_admin.dart';
import 'package:spectrum_speak/screen/parent_profile.dart';
import 'package:spectrum_speak/screen/shadow_teacher_profile.dart';
import 'package:spectrum_speak/screen/specialist_profile.dart';

class CardAdmin extends StatefulWidget {
  final String userID;
  final String userName;
  final String userCategory;
  const CardAdmin({
    super.key,
    required this.userID,
    required this.userName,
    required this.userCategory,
  });

  @override
  State<CardAdmin> createState() => _CardAdminState();
}

class _CardAdminState extends State<CardAdmin> {
  late bool isAdmin = false;
  String image = '';
  Future isUserAdmin() async {
    try {
      bool? isAdminForSystem = await isAdminSystem(widget.userID);
      setState(() {
        isAdmin = isAdminForSystem!;
      });
    } catch (e) {
      print('error to fetch data isUserAdmin:$e');
    }
  }

  Future<void> getImage() async {
    image = (await Utils.fetchUser(widget.userID)).image;
    setState(() {
      image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    isUserAdmin();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq=MediaQuery.of(context);
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
            child: CachedNetworkImage(
              width: mq.size.height * .05,
              height: mq.size.height * .05,
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover, // Set the fit property to cover
                  ),
                ),
              ),
              errorWidget: (context, url, error) =>
                  const CircleAvatar(child: Icon(CupertinoIcons.person)),
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
              isAdmin
                  ? await removeAdmin(widget.userID)
                  : await addAdmin(widget.userID);
              isUserAdmin();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: kPrimary,
              backgroundColor: isAdmin ? kBlue : kGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  7,
                ),
              ),
            ),
            icon: Icon(
              isAdmin ? FontAwesomeIcons.userMinus : FontAwesomeIcons.userPlus,
              color: kPrimary,
              size: 17,
            ),
            label: Text(
              isAdmin ? "Remove" : "Add",
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
}
