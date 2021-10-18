import 'dart:async';

import 'package:book_store_app/shares/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc {
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  SignInBloc() {
    validateBtn();
  }

  var emailValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (Validation.isEmailValid(email)) {
      sink.add(null);
      return;
    }
    sink.add('Email is wrong');
  });

  var passwordValidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (Validation.isPassword(password)) {
      sink.add(null);
      return;
    }
    sink.add('Password too short');
  });

  Stream<String> get emailStream =>
      _emailSubject.stream.transform(emailValidation);
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get passwordStream =>
      _passwordSubject.stream.transform(passwordValidation);
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  validateBtn() {
    Rx.combineLatest2(_emailSubject, _passwordSubject, (email, password) {
      return Validation.isEmailValid(email) && Validation.isPassword(password);
    }).listen((enable) {
      btnSink.add(enable);
    });
  }

  void dispose() {
    _emailSubject.close();
    _passwordSubject.close();
    _btnSubject.close();
  }
}
