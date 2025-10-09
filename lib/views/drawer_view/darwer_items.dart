// lib/res/widgets/drawer_item.dart
import 'package:flutter/material.dart';
import '../../res/colors.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;
  final double? iconSize;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final double? minLeadingWidth;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = AppColors.primaryBlue,
    this.textColor = AppColors.DarkBlue,
    this.iconSize = 22,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.padding,
    this.minLeadingWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Poppins',
        ),
      ),
      onTap: onTap,
      contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      minLeadingWidth: minLeadingWidth ?? 0,
    );
  }
}