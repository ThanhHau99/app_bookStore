import 'package:book_store_app/color_theme/change_theme_color.dart';
import 'package:book_store_app/model/app_user.dart';
import 'package:book_store_app/shares/row_widget.dart';
import 'package:book_store_app/wrap/home/blocs/load_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<LoadUserBloc>(
                builder: (context, bloc, child) => StreamBuilder(
                    stream: bloc.loadUser(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      AppUser inforUser = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: size.width * 0.35,
                              width: size.width * 0.35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Theme.of(context).backgroundColor,
                                    width: 3,
                                  )),
                              child: CircleAvatar(
                                backgroundImage: AssetImage("assets/user.jpg"),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RowWidget(
                            title: "User name: ",
                            value: inforUser.name,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RowWidget(
                            title: "Email: ",
                            value: inforUser.email,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RowWidget(
                            title: "Phone: ",
                            value: inforUser.phone,
                          ),
                        ],
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Change Theme: ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  ChangeThemebuttonWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
