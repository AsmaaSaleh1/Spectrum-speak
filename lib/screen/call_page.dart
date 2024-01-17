// Flutter imports:
import 'package:flutter/material.dart';
import 'package:spectrum_speak/main.dart';
import 'package:spectrum_speak/rest/auth_manager.dart';
import 'package:spectrum_speak/screen/all_chat.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// Project imports:
import 'common.dart';

class CallPage extends StatefulWidget {
  final callId;
  const CallPage({Key? key, this.callId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CallPageState();
}

class CallPageState extends State<CallPage> {
  ZegoUIKitPrebuiltCallController? callController;

  @override
  void initState() {
    super.initState();
    callController = ZegoUIKitPrebuiltCallController();
  }

  @override
  void dispose() {
    callController = null;
    // Call the replacement screen navigation when the screen is being disposed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(navigatorKey.currentState!.context,MaterialPageRoute(builder: ((context) => AllChat())));
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final callID = widget.callId;
    print('CallID is\n$callID');
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 1274734576 /*input your AppID*/,
        appSign:
            "1e4e35c7b8dd897fe66e3577fec04a1cfa0d4b6a76256ad243c0acfec808bb88" /*input your AppSign*/,
        userID: AuthManager.u.UserID.toString(),
        userName: AuthManager.u.UserID.toString(),
        callID: callID,
        controller: callController,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()

          /// support minimizing
          ..topMenuBarConfig.isVisible = true
          ..topMenuBarConfig.buttons = [
            ZegoMenuBarButtonName.minimizingButton,
            ZegoMenuBarButtonName.showMemberListButton,
          ]
          ..avatarBuilder = customAvatarBuilder

          ///
          ..onOnlySelfInRoom = (context) {
            if (PrebuiltCallMiniOverlayPageState.idle !=
                ZegoUIKitPrebuiltCallMiniOverlayMachine().state()) {
              /// now is minimizing state, not need to navigate, just switch to idle
              ZegoUIKitPrebuiltCallMiniOverlayMachine().switchToIdle();
            } else {
              Navigator.of(context).pop();
            }
          },
      ),
    );
  }
}
