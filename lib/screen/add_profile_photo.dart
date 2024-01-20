import 'dart:async';
import 'dart:io' show File;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/constant/utils.dart';
import 'package:spectrum_speak/rest/rest_api_signUp.dart';
import 'package:spectrum_speak/screen/edit_profile.dart';
import 'package:spectrum_speak/screen/edit_shadow_teacher_profile.dart';
import 'package:spectrum_speak/screen/edit_specialist_profile.dart';
import 'package:spectrum_speak/screen/specialist_profile.dart';
import 'package:spectrum_speak/units/build_profile_image.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:image_picker/image_picker.dart';

import 'package:spectrum_speak/rest/auth_manager.dart';
import 'main_page.dart';

class AddProfilePhoto extends StatefulWidget {
  final bool comeFromSignUp;
  String? fromWhere;
  final StreamController<String> controller = StreamController<String>();
  AddProfilePhoto({Key? key, required this.comeFromSignUp, this.fromWhere})
      : super(key: key) {}

  @override
  State<AddProfilePhoto> createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  @override
  void dispose() {
    widget.controller.close();
    super.dispose();
  }

  File? image;
  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Scaffold(
        body: Column(
          children: [
            widget.comeFromSignUp
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.fromWhere == 'Specialist')
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EditSpecialistProfile()),
                          );
                        else if (widget.fromWhere == 'Shodow Teacher')
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EditShadowTeacherProfile()),
                          );
                        else if (widget.fromWhere == 'Parent')
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfile()),
                          );
                        else
                          Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_double_arrow_left,
                            color: kDarkerColor,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Skip",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kDarkerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.fromWhere == 'Specialist') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EditSpecialistProfile()),
                          );
                        } else if (widget.fromWhere == 'Shodow Teacher')
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EditShadowTeacherProfile()),
                          );
                        else if (widget.fromWhere == 'Parent')
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditProfile()),
                          );
                        else if (widget.comeFromSignUp)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()),
                          );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.keyboard_double_arrow_left,
                            color: kDarkerColor,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Back to edit",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: kDarkerColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            Padding(
              padding: EdgeInsets.only(top: mq.size.width*0.001),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: kPrimary),
                        boxShadow: [
                          BoxShadow(
                            color: kDarkBlue.withOpacity(0.5),
                            blurRadius: 8.0, // Blur radius
                            spreadRadius: 2.0, // Spread radius
                            offset: const Offset(-5, 5),
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: image != null
                          ? ClipOval(
                              child: Center(
                                child: Stack(
                                  children: [
                                    image!.path.contains('https://')
                                        ? Image.network(
                                            image!.path,
                                            fit: BoxFit.cover,
                                            width: 200,
                                            height: 200,
                                          )
                                        : Image.file(
                                            image!,
                                            fit: BoxFit.cover,
                                            width: 200,
                                            height: 200,
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : ClipOval(
                              child: CircularProfileAvatar('',
                                  borderWidth: 1.0,
                                  borderColor: kDarkerColor,
                                  backgroundColor: kPrimary,
                                  radius: 90.0,
                                  child: CachedNetworkImage(
                                    width: mq.size.height * .5,
                                    height: mq.size.height * .5,
                                    imageUrl: AuthManager.u.image,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
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
                                  )),
                            )),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: 235,
                    height: 45,
                    child: CustomButton(
                      foregroundColor: kPrimary,
                      backgroundColor: kDarkerColor,
                      onPressed: () => {
                        pickImage(
                          ImageSource.gallery,
                        ),
                      },
                      buttonText: 'Upload from Gallery',
                      icon: const Icon(
                        Icons.image_outlined,
                        size: 25.0,
                      ),
                      iconColor: kPrimary,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 235,
                    height: 45,
                    child: CustomButton(
                      foregroundColor: kPrimary,
                      backgroundColor: kDarkerColor,
                      onPressed: () => pickImage(
                        ImageSource.camera,
                      ),
                      buttonText: 'Pick Camera',
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 25.0,
                      ),
                      iconColor: kPrimary,
                    ),
                  ),
                  const SizedBox(height: 70),
                  SizedBox(
                    width: 270,
                    height: 45,
                    child: CustomButton(
                      foregroundColor: kDarkerColor,
                      backgroundColor: kBlue,
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()),
                        );
                      },
                      buttonText: '     Done     ',
                      icon: const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 25.0,
                      ),
                      iconColor: kPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      print('im here');
      final image = await ImagePicker().pickImage(source: source);
      File img = File(image!.path);
      Utils.uploadPicture(img);
      if (image == null) {
        return;
      }
      AuthManager.u = await Utils.fetchUser('${AuthManager.u.UserID}');
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        await uploadImage(File(image.path), userId);
        setState(() {
          // Update the UI with the new image
          this.image = File(image.path);
          widget.controller.add(image.path);
        });
      } else {
        print('UserId is null');
      }
    } catch (e) {
      print("failed to uploaddddd image: $e");
    }
  }
}
