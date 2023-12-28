import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/rest/rest_api_profile.dart';

class ProfileImageDisplay extends StatefulWidget {
  final StreamController<void> updateStreamController;

  const ProfileImageDisplay({required this.updateStreamController});

  @override
  _ProfileImageDisplayState createState() => _ProfileImageDisplayState();
}

class _ProfileImageDisplayState extends State<ProfileImageDisplay> {
  late StreamSubscription<void> streamSubscription;
  late Key _futureBuilderKey;

  @override
  void initState() {
    super.initState();
    _futureBuilderKey = UniqueKey();
    streamSubscription = widget.updateStreamController.stream.listen((value) {
      print('Value from controller: ');
      // Call setState to trigger a rebuild with a new key
      setState(() {
        _futureBuilderKey = UniqueKey();
      });
      build(context);
    });
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    widget.updateStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      key: _futureBuilderKey, // Use the key here
      future: getPhotoFromDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error retrieving photo: ${snapshot.error}');
          return defaultProfileImage();
        } else {
          String imagePath = snapshot.data ?? 'images/profile.jpg';
          return Image.file(
            File(imagePath),
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          );
        }
      },
    );
  }

  Future<String?> getPhotoFromDatabase() async {
    try {
      String? userId = await AuthManager.getUserId();
      if (userId != null) {
        File? photoFile = await getPhoto(userId);
        print("path is: " + photoFile.path);
        return photoFile.path;
      } else {
        print('UserId is null');
        return 'images/profile.jpg';
      }
    } catch (error) {
      print("Error in get photo: $error");
      return 'images/profile.jpg';
    }
  }

  Widget defaultProfileImage() {
    return Image.asset(
      'images/profile.jpg',
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
