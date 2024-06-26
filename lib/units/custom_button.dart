import 'package:flutter/material.dart';

import 'package:spectrum_speak/constant/const_color.dart';

class CustomButton extends StatelessWidget {
  final Color foregroundColor;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final String buttonText;
  final Icon icon;
  final Color iconColor;

  const CustomButton({
    super.key,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.onPressed,
    required this.buttonText,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
      ).copyWith(
        shadowColor: MaterialStateProperty.resolveWith((states) {
          return kDarkBlue;
        }),
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return 15;
          }
          return 5;
        }),
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon.icon,
              size: icon.size,
              color: iconColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                buttonText,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
