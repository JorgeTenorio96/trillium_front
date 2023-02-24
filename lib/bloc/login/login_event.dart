import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInWithEmailButtonPressedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginInWithEmailButtonPressedEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
