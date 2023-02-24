import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_trillium/bloc/login/login_event.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_state.dart';
import '../../config/locator.dart';
import '../../data/services/authentication_service.dart';
import 'widgets.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = getIt<JwtAuthenticationService>();
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(authBloc, authService),
        child: SignInForm());
  }
}

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      if (_key.currentState!.validate()) {
        _loginBloc.add(LoginInWithEmailButtonPressedEvent(
            email: _emailController.text, password: _passwordController.text));
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          _showError(state.error);
        }
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Form(
          key: _key,
          autovalidateMode: _autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            children: [
              //! Textfield para el username
              SizedBox(height: 30),
              CustomTextFormField(
                  hint: 'Username',
                  obscureText: false,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null) {
                      return 'Username is required.';
                    }
                    return null;
                  }),

              //! Textfield para la password
              SizedBox(height: 15),
              CustomTextFormField(
                hint: 'Password',
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null) {
                    return 'Password is required.';
                  }
                  return null;
                },
              ),

              //! Login Button
              SizedBox(height: 30),
              CustomButton(
                text: 'Login',
                color: Colors.blue,
                padding: 35,
                textColor: Colors.white,
                onTap:
                    state is LoginLoadingState ? () {} : _onLoginButtonPressed,
              ),

              //! Register Text
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member? ',
                    style: GoogleFonts.openSans(
                        color: Color.fromARGB(255, 114, 114, 114),
                        fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Register now',
                      style: GoogleFonts.openSans(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _showError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
  }
}
