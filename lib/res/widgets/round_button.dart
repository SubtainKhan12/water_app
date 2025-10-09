import 'package:flutter/material.dart';

import '../colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double elevation;
  final bool isFullWidth;
  final double? width;
  final double height;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget? icon;

  const RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryBlue,
    this.textColor = AppColors.backgroundWhite,
    this.borderRadius = 15,
    this.elevation = 8,
    this.isFullWidth = true,
    this.width,
    this.height = 56,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w600,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: elevation,
          shadowColor: AppColors.lightSkyBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: icon != null
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        )
            : Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}