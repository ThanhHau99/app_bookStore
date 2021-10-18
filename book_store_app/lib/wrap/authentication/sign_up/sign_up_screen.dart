import 'package:book_store_app/data/auth.dart';

import 'package:book_store_app/shares/button_widget.dart';
import 'package:book_store_app/shares/loading_widget.dart';
import 'package:book_store_app/shares/text_file_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  final Function toggleView;

  const SignUpScreen({Key key, this.toggleView}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Auth _auth = Auth();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool isShowPass = true;
  bool isLoading = false;

  Widget buttonShowPass() {
    return IconButton(
        icon: Icon(
          Icons.remove_red_eye,
          color: isShowPass ? Colors.grey : Colors.tealAccent,
        ),
        onPressed: () {
          setState(() {
            isShowPass = !isShowPass;
          });
        });
  }

  void onClick() async {
    setState(() {
      isLoading = true;
    });
    Future.delayed(Duration(seconds: 5), () async {
      String result = await _auth.signUpWithEmailAndPassword(
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      setState(() {
        isLoading = false;
      });
      if (result == 'Đăng ký thành công') {
        showSnackBar(result, Colors.tealAccent);
        setState(() {
          _nameController.text = '';
          _phoneController.text = '';
          _emailController.text = '';
          _passwordController.text = '';
        });
      } else {
        showSnackBar(result, Colors.red);
        setState(() {
          _emailController.text = '';
          _passwordController.text = '';
        });
      }
    });
  }

  void showSnackBar(String text, Color color) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black38,
      elevation: 0,
      content: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: color,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoadingWidget(
      isloading: isLoading,
      child: SingleChildScrollView(
        child: Consumer<SignUpBloc>(
          builder: (context, bloc, child) => Container(
            margin: EdgeInsets.only(top: size.height * 0.2),
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                buildName(bloc),
                SizedBox(
                  height: 25,
                ),
                buildPhone(bloc),
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

  Widget buildName(SignUpBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.nameStream,
      child: Consumer<String>(
        builder: (context, msg, child) => TextFileWidget(
          controller: _nameController,
          onChange: (text) {
            bloc.nameSink.add(text);
          },
          lable: "Name",
          hintText: "Thomas",
          icon: Icon(Icons.person),
          errorText: msg,
        ),
      ),
    );
  }

  Widget buildPhone(SignUpBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.phoneStream,
      child: Consumer<String>(
        builder: (context, msg, child) => TextFileWidget(
          controller: _phoneController,
          onChange: (text) {
            bloc.phoneSink.add(text);
          },
          lable: "Phone",
          hintText: "0941xxxxxx",
          icon: Icon(Icons.phone),
          errorText: msg,
        ),
      ),
    );
  }

  Widget buildEmail(SignUpBloc bloc) {
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

  Widget buildPassword(SignUpBloc bloc) {
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
          suffixIcon: buttonShowPass(),
          isObscureText: isShowPass,
          errorText: mgs,
        ),
      ),
    );
  }

  Widget buildBtn(SignUpBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: false,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => ButtonWidget(
          lable: "Sign Up",
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
          text: "You have accounts? ",
          style: TextStyle(
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: "Sign In",
              style: TextStyle(
                color: Colors.tealAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
