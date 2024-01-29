// Flutter imports:
import 'package:flutter/material.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import 'common.dart';
class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CallPageState();
}

class CallPageState extends State<CallPage> {
  @override
  Widget build(BuildContext context) {
    final callID = 'call_id';

    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 619203223 /*input your AppID*/,
        appSign:
            "2e3bb2fb836c9eb85f0086833a149f3fa53195f46f5cc935cc23d79d4cdcd08d" /*input your AppSign*/,
        userID: AuthManager.u.UserID.toString(),
        userName: AuthManager.u.Name,
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()

          /// support minimizing
          ..topMenuBarConfig.isVisible = true
          ..topMenuBarConfig.buttons = [
            ZegoMenuBarButtonName.minimizingButton,
            ZegoMenuBarButtonName.showMemberListButton,
          ]
          ..avatarBuilder = customAvatarBuilder,
      ),
    );
  }
}
