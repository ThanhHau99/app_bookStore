import 'package:flutter/material.dart';

class TextFileWidget extends StatelessWidget {
  const TextFileWidget({
    Key key,
    this.lable,
    this.hintText,
    this.icon,
    this.suffixIcon,
    this.isObscureText = false,
    this.onChange,
    this.errorText,
    this.controller,
  }) : super(key: key);
  final String lable;
  final String hintText;
  final Widget icon;
  final Widget suffixIcon;
  final bool isObscureText;
  final Function onChange;
  final String errorText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChange,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: lable,
        hintText: hintText,
        prefixIcon: icon,
        suffixIcon: suffixIcon,
        errorText: errorText,
      ),
      obscureText: isObscureText,
    );
  }
}
