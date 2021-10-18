import 'dart:async';

import 'package:book_store_app/shares/validation.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc {
  final _nameSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _emailSubject = BehaviorSubject<String>();
  final _passwordSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  SignUpBloc() {
    validateBtn();
  }

  var nameValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (Validation.isNameValid(name)) {
      sink.add(null);
      return;
    }
    sink.add('Name is wrong');
  });

  var phoneValidation =
      StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {
    if (Validation.isPhoneValid(phone)) {
      sink.add(null);
      return;
    }
    sink.add('Phone is wrong');
  });

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

  Stream<String> get nameStream =>
      _nameSubject.stream.transform(nameValidation);
  Sink<String> get nameSink => _nameSubject.sink;

  Stream<String> get phoneStream =>
      _phoneSubject.stream.transform(phoneValidation);
  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String> get emailStream =>
      _emailSubject.stream.transform(emailValidation);
  Sink<String> get emailSink => _emailSubject.sink;

  Stream<String> get passwordStream =>
      _passwordSubject.stream.transform(passwordValidation);
  Sink<String> get passwordSink => _passwordSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  validateBtn() {
    Rx.combineLatest4(
        _nameSubject, _phoneSubject, _emailSubject, _passwordSubject,
        (name, phone, email, password) {
      return Validation.isNameValid(name) &&
          Validation.isPhoneValid(phone) &&
          Validation.isEmailValid(email) &&
          Validation.isPassword(password);
    }).listen((enable) {
      btnSink.add(enable);
    });
  }

  void dispose() {
    _nameSubject.close();
    _phoneSubject.close();
    _emailSubject.close();
    _passwordSubject.close();
    _btnSubject.close();
  }
}
