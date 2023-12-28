import 'dart:async';
import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_signUp.dart';
import 'package:spectrum_speak/units/build_profile_image.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:image_picker/image_picker.dart';

import 'package:spectrum_speak/rest/auth_manager.dart';
import 'main_page.dart';

class AddProfilePhoto extends StatefulWidget {
  final bool comeFromSignUp;
  final StreamController<String> controller = StreamController<String>();
  AddProfilePhoto({Key? key, required this.comeFromSignUp}) : super(key: key) {}

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
    return Scaffold(
      body: Column(
        children: [
          widget.comeFromSignUp
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
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
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                          child: ProfileImageDisplay(
                              updateStreamController: widget.controller),
                        ),
                ),
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
                      Navigator.pop(context);
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
    );
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
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
    } on PlatformException catch (e) {
      print("failed to upload image: $e");
    }
  }
}
