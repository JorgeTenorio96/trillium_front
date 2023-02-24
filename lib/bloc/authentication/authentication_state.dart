part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

//* Inicial
class AuthenticationInitialState extends AuthenticationState {}

//* Carga
class AuthenticationLoadingState extends AuthenticationState {}

//* No autentificado
class AuthenticationNotAuthenticatedState extends AuthenticationState {}

//* Autentificado
class AuthenticationAuthenticatedState extends AuthenticationState {
  final User user;

  AuthenticationAuthenticatedState({required this.user});

  @override
  List<Object> get props => [user];
}

//* Fallo de autenticacion
class AuthenticationFailureState extends AuthenticationState {
  final String message;

  AuthenticationFailureState({required this.message});

  @override
  List<Object> get props => [message];
}

//* Sesion expirada
class SessionExpiredState extends AuthenticationFailureState {
  SessionExpiredState() : super(message: 'Session expired. Please login again');

  String get message => super.message;

  @override
  List<Object> get props => [message];
}
