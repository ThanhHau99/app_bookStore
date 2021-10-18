import 'package:book_store_app/color_theme/my_theme.dart';
import 'package:book_store_app/color_theme/theme_provider.dart';
import 'package:book_store_app/data/auth.dart';
import 'package:book_store_app/wrap/authentication/sign_in/sign_in_bloc.dart';
import 'package:book_store_app/wrap/wrap.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/data_product.dart';
import 'wrap/authentication/sign_up/sign_up_bloc.dart';
import 'wrap/home/blocs/add_card_bloc.dart';

String uid = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  uid = await Auth.loadUserId();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BookStore App',
          themeMode: themeProvider.themeMode,
          theme: MyTheme.lightTheme,
          darkTheme: MyTheme.darkTheme,
          home: WrapWidget(
            uid: uid,
          ),
        );
      },
    );
  }
}
