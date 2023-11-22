import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:spectrum_speak/const.dart';

import 'package:spectrum_speak/widgets/smooth_star_rating.dart';

class ReviewUi extends StatelessWidget {
  final String image, name, date, comment;
  final double rating;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final bool isLess;

  const ReviewUi({
    super.key,
    required this.image,
    required this.name,
    required this.date,
    required this.comment,
    required this.rating,
    required this.onTap,
    required this.onDelete,
    required this.isLess,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                alignment: AlignmentDirectional.topStart,
                margin: const EdgeInsets.only(top: 7, right: 13, bottom: 7),
                child: CircularProfileAvatar(
                  '',
                  borderWidth: 2.0,
                  borderColor: kDarkerColor.withOpacity(0.7),
                  radius: 27.0,
                  child: Image.asset(image),
                ),
              ),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                    color: kDarkerColor,
                  ),
                ),
              ),
              PopupMenuButton<String>(
                shadowColor: kDarkerColor,
                onSelected: (value) {
                  if (value == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return ['Delete'].map((String choice) {
                    return PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: kDarkerColor,
                          ),
                          const SizedBox(width: 8),
                          Text(choice),
                        ],
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          Row(
            children: [
              SmoothStarRating(
                starCount: 5,
                allowHalfRating: true,
                rating: rating,
                borderColor: kRed,
                color: kYellow,
                size: 28,
                onRatingChanged: (value){
                  print('Rated $value stars!');
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                date, //time of add the rating
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: kDarkerColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: onTap,
            child: isLess
                ? Text(
              comment,
              style: TextStyle(
                fontSize: 12.0,
                color: kDarkerColor.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            )
                : Text(
              comment,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              //Comment
              style: TextStyle(
                fontSize: 12.0,
                color: kDarkerColor.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
