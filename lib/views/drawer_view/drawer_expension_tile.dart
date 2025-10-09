// lib/res/widgets/drawer_expansion_tile.dart
import 'package:flutter/material.dart';
import '../../res/colors.dart';

class DrawerExpansionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;
  final Color? iconColor;
  final Color? textColor;
  final Color? arrowColor;
  final double? iconSize;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? tilePadding;
  final EdgeInsetsGeometry? childrenPadding;
  final bool? initiallyExpanded;

  const DrawerExpansionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.children,
    this.iconColor = AppColors.primaryBlue,
    this.textColor = AppColors.DarkBlue,
    this.arrowColor = AppColors.primaryBlue,
    this.iconSize = 22,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
    this.tilePadding,
    this.childrenPadding,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
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
      children: children,
      collapsedIconColor: arrowColor,
      iconColor: arrowColor,
      tilePadding: tilePadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      childrenPadding: childrenPadding ?? const EdgeInsets.only(left: 20),
      initiallyExpanded: initiallyExpanded ?? false,
    );
  }
}