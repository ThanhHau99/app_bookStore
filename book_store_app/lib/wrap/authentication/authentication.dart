import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_in/sign_in_bloc.dart';
import 'sign_in/sign_in_screen.dart';
import 'sign_up/sign_up_bloc.dart';
import 'sign_up/sign_up_screen.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SignInBloc>.value(
          value: SignInBloc(),
        ),
        Provider<SignUpBloc>.value(
          value: SignUpBloc(),
        ),
      ],
      child: showSignIn
          ? SignInScreen(toggleView: toggleView)
          : SignUpScreen(toggleView: toggleView),
    );
  }
}
