import 'package:book_store_app/data/data_product.dart';
import 'package:book_store_app/wrap/home/blocs/add_card_bloc.dart';
import 'package:book_store_app/wrap/home/blocs/load_user_bloc.dart';
import 'package:book_store_app/wrap/home/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DataProducts>.value(value: DataProducts()),
        ChangeNotifierProvider<AddCardBloc>.value(
          value: AddCardBloc(),
        ),
        Provider<LoadUserBloc>.value(value: LoadUserBloc()),
      ],
      child: HomeScreen(),
    );
  }
}
