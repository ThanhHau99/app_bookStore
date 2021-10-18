import 'package:book_store_app/color_theme/change_theme_color.dart';
import 'package:book_store_app/data/auth.dart';
import 'package:book_store_app/main.dart';
import 'package:book_store_app/shares/row_widget.dart';
import 'package:book_store_app/wrap/authentication/authentication.dart';
import 'package:book_store_app/wrap/home/blocs/add_card_bloc.dart';
import 'package:book_store_app/shares/base_app_bar.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/badge_widget.dart';
import 'components/build_body.dart';
import 'components/build_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context,
        title: "Home Page",
        actions: [
          BadgeWidget(),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              _auth.signOut();
              print("sign out");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Authentication(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      drawer: BuildDrawer(),
      body: BuildBody(),
    );
  }
}
