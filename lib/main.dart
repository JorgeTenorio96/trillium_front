import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_trillium/trillium_app.dart';
import 'package:flutter_trillium/views/screens/main_page.dart';

import 'bloc/authentication/authentication_bloc.dart';
import 'config/locator.dart';
import 'data/services/authentication_service.dart';
import 'views/views.dart';

void main() {
  setupAsyncDependencies();
  configureDependencies();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      final authService = getIt<JwtAuthenticationService>();
      return AuthenticationBloc(authService)..add(AppLoadedEvent());
    },
    child: Trillium(),
  ));
}
