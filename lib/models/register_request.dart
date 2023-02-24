// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  String username;
  String password;
  String verifyPassword;
  String email;
  String verifyEmail;
  String fullname;
  RegisterRequest({
    required this.username,
    required this.password,
    required this.verifyPassword,
    required this.email,
    required this.verifyEmail,
    required this.fullname,
  });

  @override
  List<Object> get props {
    return [
      username,
      password,
      verifyPassword,
      email,
      verifyEmail,
      fullname,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'verifyPassword': verifyPassword,
      'email': email,
      'verifyEmail': verifyEmail,
      'fullname': fullname,
    };
  }

  factory RegisterRequest.fromMap(Map<String, dynamic> map) {
    return RegisterRequest(
      username: map['username'] as String,
      password: map['password'] as String,
      verifyPassword: map['verifyPassword'] as String,
      email: map['email'] as String,
      verifyEmail: map['verifyEmail'] as String,
      fullname: map['fullname'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequest.fromJson(String source) => RegisterRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
