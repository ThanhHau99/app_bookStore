import 'package:badges/badges.dart';
import 'package:book_store_app/model/book.dart';
import 'package:book_store_app/wrap/home/blocs/add_card_bloc.dart';
import 'package:book_store_app/wrap/shopping_screen.dart/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BadgeWidget extends StatefulWidget {
  const BadgeWidget({
    Key key,
  }) : super(key: key);

  @override
  _BadgeWidgetState createState() => _BadgeWidgetState();
}

class _BadgeWidgetState extends State<BadgeWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AddCardBloc>(
      builder: (context, bloc, child) => Container(
        margin: EdgeInsets.only(right: 10),
        child: Badge(
          position: BadgePosition.topEnd(top: 0, end: 3),
          animationDuration: Duration(milliseconds: 300),
          animationType: BadgeAnimationType.slide,
          badgeContent: Text(
            bloc.listBooks.length.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              print("shopping cart");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartScreen(
                    bloc: bloc,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
