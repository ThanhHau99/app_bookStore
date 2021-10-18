import 'package:flutter/material.dart';

AppBar baseAppBar(BuildContext context,
    {String title, List<Widget> actions, Widget leading}) {
  return AppBar(
    backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w500,
      ),
    ),
    actions: actions,
    leading: leading,
  );
}
