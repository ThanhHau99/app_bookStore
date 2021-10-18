import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({
    Key key,
    @required this.lable,
    @required this.icon,
    @required this.onPress,
  }) : super(key: key);
  final String lable;
  final Icon icon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Text(
            lable,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          icon,
        ],
      ),
    );
  }
}
