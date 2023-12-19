import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:spectrum_speak/widgets/image_widget.dart';

class AddProfilePhoto extends StatefulWidget {
  const AddProfilePhoto({super.key});

  @override
  State<AddProfilePhoto> createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    child: ImageWidget(
                        image: image!,
                        onClicked: (source) => pickImage(source),
                      ),
                  )
                  : ClipOval(
                      child: Image.asset(
                        'images/profile.jpg',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(height: 35),
            SizedBox(
              width: 235,
              height: 45,
              child: CustomButton(
                foregroundColor: kPrimary,
                backgroundColor: kDarkerColor,
                onPressed: () => pickImage(ImageSource.gallery),
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
                onPressed: () => pickImage(ImageSource.camera),
                buttonText: 'Pick Camera',
                icon: const Icon(
                  Icons.camera_alt,
                  size: 25.0,
                ),
                iconColor: kPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    // If running on mobile, use ImagePicker package
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        return;
      }
      //final imageTemp = File(image.path);
      final imagePermanent = await saveImagePermanently(image.path);
      setState(() {
        this.image = imagePermanent;
      });
    } on PlatformException catch (e) {
      print("failed to upload image: $e");
    }
  }

  Future<File> saveImagePermanently(String path) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(path);
    final image = File('${directory.path}/$name');
    return File(path).copy(image.path);
  }
}
