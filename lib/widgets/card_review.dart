import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/rest/rest_api_rate.dart';
import 'package:spectrum_speak/units/review_ui.dart';

class CardReview extends StatefulWidget {
  final String userId;
  const CardReview({
    super.key,
    required this.userId,
  });

  @override
  State<CardReview> createState() => _CardReviewState();
}

class _CardReviewState extends State<CardReview> {
  bool isMore = false;
  bool isMenuOpen = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getReviews(widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // You can return a loading indicator here if needed
            return Container(
              color: kPrimary,
              child: Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  backgroundColor: kDarkBlue,
                  color: kDarkBlue,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle the error
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            // Build your UI with the fetched data
            dynamic data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(19.0),
              child: Container(
                width: 300,
                height: 180,
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: kDarkBlue.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ReviewUi(
                  image: 'images/prof.png',
                  name: data["UserName"],
                  date: data["Date"],
                  comment:data["Comment"],
                  rating: double.parse(data["Rate"]),
                  onTap: () => setState(() {
                    isMore = !isMore;
                  }),
                  onDelete: () {
                    setState(() {
                      isMenuOpen = !isMenuOpen;
                    });
                  },
                  isLess: isMore,
                ),
              ),
            );
          } else {
            // Return a default UI if no data is available
            return const Text('No data available');
          }
        });
  }
}

Future<dynamic> getReviews(String userID) async {
  try {
    var data = await getReview(userID);
    print(data);
    return data;
  } catch (e) {
    print("error$e");
  }
}
