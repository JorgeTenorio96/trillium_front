import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../trillium_app.dart';
import 'login_page.dart';
import 'main_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        GlobalContext.ctx = context;
        if (state is AuthenticationAuthenticatedState) {
          return MainPage(
            user: state.user,
          );
        }
        return LoginPage();
      },
    );
    // return const Scaffold(
    //   body: Center(child: CircularProgressIndicator()),
    // );
  }
}
