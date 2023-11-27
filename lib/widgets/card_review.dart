import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/review_ui.dart';

class CardReview extends StatefulWidget {
  const CardReview({
    super.key,
  });

  @override
  State<CardReview> createState() => _CardReviewState();
}

class _CardReviewState extends State<CardReview> {
  bool isMore = false;
  bool isMenuOpen = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Container(
        width: 300,
        height: 170,
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
          name: "User Name",
          date: "7th Oct",
          comment: "Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment Lorem ipsum comment",
          rating: 4,
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
  }
}
