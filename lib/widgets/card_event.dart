// import 'package:circular_profile_avatar/circular_profile_avatar.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// import 'package:spectrum_speak/constant/const_color.dart';
// import 'package:spectrum_speak/rest/auth_manager.dart';
// import 'package:spectrum_speak/rest/rest_api_profile_delete.dart';
// import 'package:spectrum_speak/screen/edit_child_card.dart';
// import 'package:spectrum_speak/screen/parent_profile.dart';
//
// class CardEvent extends StatelessWidget {
//
//   const CardEvent({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<String?>(
//         future: _getID(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // You can return a loading indicator here if needed
//             return Container(
//               color: kPrimary,
//               child: Container(
//                 alignment: Alignment.center,
//                 child: const CircularProgressIndicator(
//                   backgroundColor: kDarkBlue,
//                   color: kDarkBlue,
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             // Handle the error
//             return Text('Error: ${snapshot.error}');
//           } else if (snapshot.hasData) {
//             // Build your UI with the fetched data
//             String userIdLogin = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(19.0),
//               child: Container(
//                 width: 300,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: kPrimary,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: kDarkBlue.withOpacity(0.5),
//                       spreadRadius: 3,
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Stack(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: Container(
//                               width: 100, // Adjust the width as needed
//                               height: 100, // Adjust the height as needed
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: kDarkBlue.withOpacity(0.5),
//                                     blurRadius: 8.0, // Blur radius
//                                     spreadRadius: 2.0, // Spread radius
//                                     offset: const Offset(-5, 5),
//                                   ),
//                                 ],
//                               ),
//                               child: CircularProfileAvatar(
//                                 '',
//                                 borderWidth: 1.0,
//                                 radius: 50.0,
//                                 child: Image.asset('images/prof.png'),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 25.0,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(3.0),
//                               child: Text(
//                                 toBeginningOfSentenceCase(userName) ?? "",
//                                 style: TextStyle(
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: kDarkerColor,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 gender,
//                                 style: TextStyle(
//                                   fontSize: 14.0,
//                                   color: kBlue,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 birthDate, //Birth Date
//                                 style: TextStyle(
//                                   fontSize: 14.0,
//                                   color: kRed,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 degreeOfAutism, //Birth Date
//                                 style: TextStyle(
//                                   fontSize: 14.0,
//                                   color: kGreen,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             // Return a default UI if no data is available
//             return const Text('No data available');
//           }
//         });
//   }
//
//   Future<String?> _getID() async {
//     try {
//       // Check if userId is not null before calling profileSpecialist
//       String? userIdLogin = await AuthManager.getUserId();
//       return userIdLogin;
//     } catch (e) {
//       print("error in user ID");
//     }
//     return null;
//   }
// }
