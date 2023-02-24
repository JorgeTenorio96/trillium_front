import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_trillium/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_trillium/views/widgets/login_form_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Icon(
                  Icons.art_track_rounded,
                  size: 150,
                  color: Colors.blue,
                ),
                Text(
                  'Trillium',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 60),
                Text(
                  'Hello there',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic),
                ),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    final authBloc =
                        BlocProvider.of<AuthenticationBloc>(context);
                    if (state is AuthenticationNotAuthenticatedState) {
                      return LoginForm();
                    }
                    if (state is AuthenticationFailureState ||
                        state is SessionExpiredState) {
                      var msg = (state as AuthenticationFailureState).message;
                      return Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(msg),
                          TextButton(
                            child: Text('Retry'),
                            onPressed: () {
                              authBloc.add(AppLoadedEvent());
                            },
                          )
                        ],
                      ));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
