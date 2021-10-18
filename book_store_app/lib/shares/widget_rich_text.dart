import 'package:flutter/material.dart';

class WidgetRichText extends StatelessWidget {
  const WidgetRichText({
    Key key,
    this.title,
    this.value,
    this.dv,
  }) : super(key: key);
  final String title;
  final String value;
  final String dv;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontSize: 20,
          color: Colors.red,
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).iconTheme.color,
            ),
            children: [
              TextSpan(
                text: dv,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
