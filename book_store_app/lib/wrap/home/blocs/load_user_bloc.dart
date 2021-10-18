import 'package:book_store_app/data/database_user.dart';
import 'package:book_store_app/model/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoadUserBloc {
  DataBaseUser dataBaseUser =
      DataBaseUser(uid: FirebaseAuth.instance.currentUser.uid);

  Stream<AppUser> loadUser() {
    return dataBaseUser.userData;
  }
}
