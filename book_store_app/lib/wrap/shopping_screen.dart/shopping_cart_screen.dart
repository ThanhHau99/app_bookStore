import 'package:book_store_app/shares/buy_button.dart';
import 'package:book_store_app/shares/card_widget.dart';
import 'package:book_store_app/shares/base_app_bar.dart';
import 'package:book_store_app/shares/widget_rich_text.dart';
import 'package:book_store_app/wrap/home/blocs/add_card_bloc.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  final AddCardBloc bloc;
  const ShoppingCartScreen({Key key, this.bloc}) : super(key: key);
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  int total = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: baseAppBar(
        context,
        title: "My shopping cart",
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: widget.bloc.listBooks.length,
            itemBuilder: (context, index) {
              return CardWidget(
                image: widget.bloc.listBooks[index].image,
                name: widget.bloc.listBooks[index].name,
                quantity: widget.bloc.listBooks[index].quantity,
                price: widget.bloc.listBooks[index].price,
                button: BuyButton(
                  lable: "Delete",
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPress: (() {
                    setState(() {
                      widget.bloc.removeCard(widget.bloc.listBooks[index]);
                    });
                  }),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.1,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(3, 4),
                    blurRadius: 4,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetRichText(
                        title: "Quantity: ",
                        value: widget.bloc.listBooks.length.toString(),
                        dv: " Cuốn",
                      ),
                      WidgetRichText(
                        title: "Total: ",
                        value: widget.bloc.price.toString(),
                        dv: " vnd",
                      ),
                    ],
                  ),
                  BuyButton(
                      lable: "Buy",
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPress: () {})
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
