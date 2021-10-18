import 'package:book_store_app/data/database_user.dart';
import 'package:book_store_app/model/book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AddCardBloc with ChangeNotifier {
  DataBaseUser dataBaseUser =
      DataBaseUser(uid: FirebaseAuth.instance.currentUser.uid);

  List<Book> listBooks = [];
  int price = 0;

  addCard(Book book) async {
    listBooks.add(book);
    price += book.price;
    await dataBaseUser.addBook(book);

    print(book.name);
    notifyListeners();
  }

  removeCard(Book book) async {
    listBooks.remove(book);
    price -= book.price;
    await dataBaseUser.deleteBook(book);
    notifyListeners();
  }
}
