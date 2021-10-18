import 'package:book_store_app/data/auth.dart';

import 'package:book_store_app/shares/button_widget.dart';
import 'package:book_store_app/shares/loading_widget.dart';
import 'package:book_store_app/shares/text_file_widget.dart';
import 'package:book_store_app/wrap/authentication/sign_in/sign_in_bloc.dart';
import 'package:book_store_app/wrap/home/home_screen/home.dart';
import 'package:book_store_app/wrap/home/home_screen/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  final Function toggleView;

  const SignInScreen({Key key, this.toggleView}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Auth _auth = Auth();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;

  bool isShowPass = true;

  void showSnackBar(String text) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black38,
      content: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void onClick() {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 5), () async {
      String result = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (result == 'Success') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
            (route) => false);
      } else {
        showSnackBar(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoadingWidget(
      isloading: isLoading,
      child: SingleChildScrollView(
        child: Consumer<SignInBloc>(
          builder: (context, bloc, child) => Container(
            margin: EdgeInsets.only(top: size.height * 0.3),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SIGN IN",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                buildEmail(bloc),
                SizedBox(
                  height: 20,
                ),
                buildPassword(bloc),
                SizedBox(
                  height: 25,
                ),
                buildBtn(bloc),
                SizedBox(
                  height: 25,
                ),
                buildSignUp(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEmail(SignInBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.emailStream,
      child: Consumer<String>(
        builder: (context, msg, child) => TextFileWidget(
          controller: _emailController,
          onChange: (text) {
            bloc.emailSink.add(text);
          },
          lable: "Email",
          hintText: "abc@gmail.com",
          icon: Icon(Icons.email),
          errorText: msg,
        ),
      ),
    );
  }

  Widget buildPassword(SignInBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.passwordStream,
      child: Consumer<String>(
        builder: (context, mgs, child) => TextFileWidget(
          controller: _passwordController,
          onChange: (text) {
            bloc.passwordSink.add(text);
          },
          lable: "Password",
          hintText: "******",
          icon: Icon(Icons.lock),
          suffixIcon: buildShowPass(),
          isObscureText: isShowPass,
          errorText: mgs,
        ),
      ),
    );
  }

  Widget buildBtn(SignInBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: false,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => ButtonWidget(
          lable: "Sign In",
          onPress: enable
              ? () {
                  onClick();
                }
              : null,
        ),
      ),
    );
  }

  Widget buildSignUp() {
    return GestureDetector(
      onTap: () {
        widget.toggleView();
      },
      child: RichText(
        text: TextSpan(
          text: "Don't have account? ",
          style: TextStyle(
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: "Sign Up",
              style: TextStyle(
                color: Colors.tealAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShowPass() {
    return Consumer<SignInBloc>(
      builder: (context, bloc, child) => IconButton(
        onPressed: () {
          setState(() {
            isShowPass = !isShowPass;
          });
        },
        icon: Icon(
          Icons.remove_red_eye,
          color: isShowPass ? Colors.grey : Colors.tealAccent,
        ),
      ),
    );
  }
}
