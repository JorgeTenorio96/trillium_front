part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class AppLoadedEvent extends AuthenticationEvent {}

// Fired when a user has successfully logged in
class UserLoggedInEvent extends AuthenticationEvent {
  final User user;

  UserLoggedInEvent({required this.user});

  @override
  List<Object> get props => [user];
}

// Fired when the user has logged out
class UserLoggedOutEvent extends AuthenticationEvent {}


// Se emite cuando la sesión ha expirado
class SessionExpiredEvent extends AuthenticationEvent {}
