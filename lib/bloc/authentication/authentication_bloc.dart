import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/client/rest_client.dart';
import '../../data/services/authentication_service.dart';
import '../../models/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;

  AuthenticationBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(AuthenticationInitialState()) {
    on<AppLoadedEvent>(_onAppLoaded);
    on<UserLoggedInEvent>(_onUserLoggedIn);
    on<UserLoggedOutEvent>(_onUserLoggedOut);
    on<SessionExpiredEvent>(_onSessionExpired);
  }

  _onAppLoaded(
    AppLoadedEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      final currentUser = await _authenticationService.getCurrentUser();

      if (currentUser != null) {
        emit(AuthenticationAuthenticatedState(user: currentUser));
      } else {
        emit(AuthenticationNotAuthenticatedState());
      }
    } on UnauthorizedException catch (e) {
      print(e);
      emit(AuthenticationNotAuthenticatedState());
    } on Exception catch (e) {
      emit(AuthenticationFailureState(
          message: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  _onUserLoggedIn(
    UserLoggedInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationAuthenticatedState(user: event.user));
  }

  _onUserLoggedOut(
    UserLoggedOutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationService.signOut();
    emit(AuthenticationNotAuthenticatedState());
  }

  _onSessionExpired(
    SessionExpiredEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    //emit(AuthenticationFailure(message: 'An unknown error occurred: ${e.toString()}'));

    await _authenticationService.signOut();
    emit(SessionExpiredState());
  }
}
