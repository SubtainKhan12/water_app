// lib/res/widgets/drawer_sub_item.dart
import 'package:flutter/material.dart';
import '../../res/colors.dart';

class DrawerSubItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? dotColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;

  const DrawerSubItem({
    super.key,
    required this.title,
    required this.onTap,
    this.dotColor = AppColors.skyBlue,
    this.fontSize = 13,
    this.fontWeight = FontWeight.normal,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: dotColor,
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.DarkBlue,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Poppins',
        ),
      ),
      onTap: onTap,
      contentPadding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      minLeadingWidth: 0,
      dense: true,
    );
  }
}