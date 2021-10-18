import 'package:book_store_app/data/database_user.dart';
import 'package:book_store_app/model/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Save uid
  static void saveUserId(String uid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('uid', uid);
  }

  // load user id
  static Future<String> loadUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String loadUid = pref.getString('uid');
    return loadUid;
  }

  //Sign In with email and password
  Future<String> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user;
      //save user id
      saveUserId(user.uid);
      DataBaseUser(uid: user.uid).userData;
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Tài khoản chưa được đăng ký';
      } else if (e.code == 'wrong-password') {
        return 'Mật khẩu nhập sai';
      }
    }
  }

  //Sign Up with email and password
  Future<String> signUpWithEmailAndPassword({
    String name,
    String phone,
    String email,
    String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // create a new document for user with uid
      await DataBaseUser(uid: user.uid).updateUserData(
        name: name,
        phone: phone,
        email: email,
      );

      //save user id
      saveUserId(user.uid);
      DataBaseUser(uid: user.uid).userData;
      return 'Đăng ký thành công';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Mật khẩu khá yếu';
      } else if (e.code == 'email-already-in-use') {
        return 'Email đã được sử dụng';
      }
    } catch (e) {
      return e.toString();
    }
  }

  //Sign out
  Future signOut() async {
    try {
      saveUserId('');
      return await _auth.signOut();
    } catch (e) {
      return e.toString();
    }
  }
}
