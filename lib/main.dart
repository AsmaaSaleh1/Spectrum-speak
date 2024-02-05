import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart'
    as fni;
import 'package:awesome_notifications/src/enumerators/notification_importance.dart'
    as ani;
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spectrum_speak/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spectrum_speak/modules/NotificationController.dart';
import 'package:spectrum_speak/screen/welcome.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'constant/const_color.dart';

late Size mq;
final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializeFirebase();

  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: "call_channel",
        channelName: "Call Channel",
        channelDescription: "Channel of call",
        defaultColor: kRed,
        ledColor: Colors.white,
        importance: ani.NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Ringtone)
  ]);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  ZegoUIKit().initLog().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String? title = message.notification!.title;
      String? body = message.notification!.body;

      AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 123,
            channelKey: "call_channel",
            color: Colors.white,
            title: title,
            body: body,
            category: NotificationCategory.Call,
            wakeUpScreen: true,
            fullScreenIntent: true,
            autoDismissible: false,
            backgroundColor: Colors.orange,
          ),
          actionButtons: [
            NotificationActionButton(
                key: "ACCEPT",
                label: 'Accept',
                color: Colors.green,
                autoDismissible: true),
            NotificationActionButton(
                key: "REJECT",
                label: 'Reject',
                color: Colors.red,
                autoDismissible: true)
          ]);
      AwesomeNotifications().setListeners(
          onActionReceivedMethod: NotificationController.onActionReceivedMethod,
          onNotificationCreatedMethod:
              NotificationController.onNotificationCreatedMethod,
          onNotificationDisplayedMethod:
              NotificationController.onNotificationDisplayedMethod,
          onDismissActionReceivedMethod:
              NotificationController.onDismissActionReceivedMethod);
    });
  }

  Map<String, WidgetBuilder> routess = {
    '/welcome': (context) => const Welcome(),
  };
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Spectrum Speak',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: kDarkBlue,
            iconTheme: const IconThemeData(color: kPrimary),
            titleTextStyle: TextStyle(
              color: kPrimary,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.tinos().fontFamily,
            ),
          ),
          scaffoldBackgroundColor: kPrimary,
          primaryColor: kPrimary,
          iconTheme: IconThemeData(color: kDarkerColor),
          fontFamily: GoogleFonts.tinos().fontFamily,
          textTheme: GoogleFonts.tinosTextTheme(),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: kDarkBlue, // Set the cursor color here
            selectionHandleColor:
                kDarkBlue, // Set the selection handle color if needed
            selectionColor: kDarkBlue,
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: kDarkBlue), // Set the focus color here
            ),
          ),
        ),
        home: const Scaffold(
          body: Welcome(),
        ),
        navigatorKey: navigatorKey,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              child!,

              /// support minimizing
              // ZegoUIKitPrebuiltCallMiniOverlayPage(
              //   contextQuery: () {
              //     return navigatorKey.currentState!.context;
              //   },
              // ),
            ],
          );
        });
  }
}

_initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseAuth.instance
  // .authStateChanges()
  // .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });
  if (!kIsWeb || kIsWeb) {
    var result = await FlutterNotificationChannel.registerNotificationChannel(
      description: 'For Showing Messaging ',
      id: 'chats',
      importance: fni.NotificationImportance.IMPORTANCE_HIGH,
      name: 'Chats',
      visibility: NotificationVisibility.VISIBILITY_PUBLIC,
    );
    print('res $result');
  }
}

Future<void> backgroundHandler(RemoteMessage message) async {
  String? title = message.notification!.title;
  String? body = message.notification!.body;
  if (body == 'Incoming Call') {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 123,
          channelKey: "call_channel",
          color: Colors.white,
          title: title,
          body: body,
          category: NotificationCategory.Call,
          wakeUpScreen: true,
          fullScreenIntent: true,
          autoDismissible: false,
          backgroundColor: Colors.orange,
        ),
        actionButtons: [
          NotificationActionButton(
              key: "ACCEPT",
              label: 'Accept',
              color: Colors.green,
              autoDismissible: true),
          NotificationActionButton(
              key: "REJECT",
              label: 'Reject',
              color: Colors.red,
              autoDismissible: true)
        ]);
  } else {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 125,
      channelKey: "msg_channel",
      color: Colors.white,
      title: title,
      body: body,
      category: NotificationCategory.Message,
      wakeUpScreen: true,
      fullScreenIntent: true,
      autoDismissible: false,
      backgroundColor: Colors.orange,
    ));
  }
}
