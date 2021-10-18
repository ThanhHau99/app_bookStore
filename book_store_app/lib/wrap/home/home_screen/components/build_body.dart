import 'package:book_store_app/data/data_product.dart';
import 'package:book_store_app/model/book.dart';
import 'package:book_store_app/shares/buy_button.dart';
import 'package:book_store_app/shares/card_widget.dart';
import 'package:book_store_app/wrap/home/blocs/add_card_bloc.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildBody extends StatefulWidget {
  const BuildBody({
    Key key,
  }) : super(key: key);

  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProducts>(
      builder: (context, bloc, child) {
        return Container(
          child: StreamBuilder(
            initialData: null,
            stream: bloc.getData(),
            builder: (context, snapshot) {
              List<Book> data = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return CardWidget(
                      image: data[index].image,
                      name: data[index].name,
                      quantity: data[index].quantity,
                      price: data[index].price,
                      button: Consumer<AddCardBloc>(
                        builder: (context, bloc, child) => BuyButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          lable: "Add cart",
                          onPress: () {
                            print("add cart");
                            bloc.addCard(data[index]);
                          },
                        ),
                      ));
                },
              );
            },
          ),
        );
      },
    );
  }
}
