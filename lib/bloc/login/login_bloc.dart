import 'package:bloc/bloc.dart';

import '../../data/client/rest_client.dart';
import '../../data/services/authentication_service.dart';
import '../authentication/authentication_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authenticationBloc;
  final AuthenticationService _authenticationService;

  LoginBloc(AuthenticationBloc authenticationBloc, AuthenticationService authenticationService)
      : assert(authenticationBloc != null),
        assert(authenticationService != null),
        _authenticationBloc = authenticationBloc,
        _authenticationService = authenticationService,
        super(LoginInitialState()) {
          on<LoginInWithEmailButtonPressedEvent>(__onLogingInWithEmailButtonPressed);
        }


  __onLogingInWithEmailButtonPressed(
    LoginInWithEmailButtonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());
    try {
      final user = await _authenticationService.signInWithEmailAndPassword(event.email, event.password);
      if (user != null) {
        _authenticationBloc.add(UserLoggedInEvent(user: user));
        emit(LoginSuccessState());
        emit(LoginInitialState());
      } else {
        emit(LoginFailureState(error: 'Something very weird just happened'));
      }
    } on AuthenticationException catch (e) {
      emit(LoginFailureState(error: e.message));
    } on CustomException catch (err) {
      emit(LoginFailureState(error:'An unknown error occurred ${err.message}'));
    }
  }

  
}
