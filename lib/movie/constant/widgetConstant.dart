import 'package:flutter/material.dart';

class TextFormFieldwidget extends StatelessWidget {
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int minLines;
  final int maxLines;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final TextEditingController? controller;
  final Color colors;
  final Color colortext;
  TextFormFieldwidget(
      {this.label,
      this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.validator,
      this.onSaved,
      this.maxLines = 1,
      this.minLines = 1,
      required this.obscureText,
      super.key,
      this.controller,
      required this.colors,
      required this.colortext});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autofocus: false,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
      minLines: minLines,
      maxLines: maxLines,

      style: TextStyle(fontSize: 16, color: colortext),
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffix: suffixIcon,
        filled: true,
        fillColor: colors,
        labelStyle: TextStyle(color: colors),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors),
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
      ),
    );
  }
}
