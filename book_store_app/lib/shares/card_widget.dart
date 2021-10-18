import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
    this.image,
    this.name,
    this.quantity,
    this.price,
    this.button,
  }) : super(key: key);

  final String image;
  final String name;
  final int quantity;
  final int price;
  final Widget button;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: double.infinity,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        children: [
          _buildImage(size, context),
          _buildBookDetail(context),
        ],
      ),
    );
  }

  Widget _buildImage(Size size, BuildContext context) {
    return Container(
      width: size.width * 0.3,
      height: size.height * 0.2,
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).backgroundColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBookDetail(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(
          left: 15,
          top: 10,
          bottom: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              quantity.toString() + " cuốn",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  price.toString() + " vnđ",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                button,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
