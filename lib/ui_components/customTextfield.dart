import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextInputType inputType;
  final bool obscureText;
  final Widget? prefixIcon;
  final bool showSuffixIcon;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final bool readOnly; // New parameter

  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.showSuffixIcon = false,
    this.controller,
    this.textStyle,
    this.readOnly = false, // Initialize with default value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: obscureText,
      style: textStyle ?? Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold, color: Colors.grey),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: showSuffixIcon ? Icon(Icons.arrow_forward, size: 20,) : null,
      ),
      readOnly: readOnly, // Apply readOnly property
    );
  }
}
