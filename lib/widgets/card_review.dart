import 'package:flutter/material.dart';
import 'package:spectrum_speak/constant/const_color.dart';
import 'package:spectrum_speak/units/review_ui.dart';

class CardReview extends StatefulWidget {
  final bool isCenter;
  final String ID;
  final String userId;
  final String userIdLogin;
  final String rateId;
  final String userName;
  final String date;
  final String comment;
  final String rate;
  const CardReview({
    super.key,
    required this.isCenter,
    required this.userId,
    required this.rateId,
    required this.userName,
    required this.date,
    required this.comment,
    required this.rate,
    required this.userIdLogin,
    required this.ID,
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
          rateID: widget.rateId,
          name: widget.userName,
          date: widget.date,
          comment: widget.comment,
          rating: double.parse(widget.rate),
          userId: widget.userId,
          userIdLogin: widget.userIdLogin,
          ID: widget.ID,
          onTap: () => setState(() {
            isMore = !isMore;
          }),
          onDelete: () {
            setState(() {
              isMenuOpen = !isMenuOpen;
            });
          },
          isLess: isMore,
          isCenter: widget.isCenter,
        ),
      ),
    );
  }
}
