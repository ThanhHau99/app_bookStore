import 'package:book_store_app/data/data_product.dart';
import 'package:book_store_app/wrap/authentication/authentication.dart';

import 'package:flutter/material.dart';

import 'home/home_screen/home.dart';

class WrapWidget extends StatelessWidget {
  final String uid;

  const WrapWidget({Key key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Uid: $uid");
    return uid.isEmpty ? Authentication() : Home();
  }
}
