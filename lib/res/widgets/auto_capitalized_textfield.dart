// lib/res/widgets/auto_capitalize_text_field.dart
import 'package:flutter/material.dart';

import '../colors.dart';

class AutoCapitalizeTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final String? helperText;
  final String? Function(String?)? validator;

  const AutoCapitalizeTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleObscure,
    this.helperText,
    this.validator,
  });

  @override
  State<AutoCapitalizeTextField> createState() =>
      _AutoCapitalizeTextFieldState();
}

class _AutoCapitalizeTextFieldState extends State<AutoCapitalizeTextField> {
  void _autoCapitalizeText(String value) {
    final newValue = value.toUpperCase();
    if (newValue != value) {
      widget.controller.value = widget.controller.value.copyWith(
        text: newValue,
        selection: TextSelection.collapsed(offset: newValue.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      style: const TextStyle(
        color: AppColors.DarkBlue,
        fontFamily: 'Poppins',
        letterSpacing: 1.0,
      ),
      onChanged: _autoCapitalizeText,
      textCapitalization: TextCapitalization.characters,
      validator: widget.validator,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: AppColors.skyBlue,
          fontFamily: 'Poppins',
        ),
        helperText: widget.helperText,
        helperStyle: TextStyle(
          color: AppColors.skyBlue.withValues(alpha: 0.7),
          fontSize: 12,
          fontFamily: 'Poppins',
        ),
        prefixIcon: Icon(widget.prefixIcon, color: AppColors.primaryBlue),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: widget.onToggleObscure,
                icon: Icon(
                  widget.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.primaryBlue,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.lightSkyBlue, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        errorStyle: const TextStyle(
          color: AppColors.errorRed,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}
