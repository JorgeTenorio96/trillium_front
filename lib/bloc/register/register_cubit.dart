import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'register_state.dart';
//! Guia que estoy siguiendo
//! https://medium.flutterdevs.com/validation-using-bloc-in-flutter-5de8c7ec5ad4
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final _fullnameController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _verifiedPasswordController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _verifiedEmailController = BehaviorSubject<String>();

  Stream<String> get usernameStream => _usernameController.stream;
  Stream<String> get fullnameStream => _fullnameController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<String> get verifiedPasswordStream =>
      _verifiedPasswordController.stream;
  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get verifiedEmailStream => _verifiedEmailController.stream;

  void dispose() {
    // updateUserName('');
    // updatePassword('');
    // updatePhoneNumber('');
  }

  //validation of UserName
  void updateUserName(String userName) {
    if (userName.length < 0) {
      _usernameController.sink.addError("The username field can't be empty");
    } else {
      _usernameController.sink.add(userName);
    }
  }

//validation of Password
  void updatePassword(String password) {
    if (password.length <= 8) {
      _passwordController.sink
          .addError("The password need to be longer than 8 characters");
    } else if (!password.containsLowercase && !password.containsUppercase) {
      _passwordController.sink
          .addError("The password needs to have both lowercase and uppercase characters");
    } else if (!password.containsNumber) {
      _passwordController.sink
          .addError("The password needs to have at least one number");
    } else {
      _passwordController.sink.add(password);
    }
  }
}

extension StringValidators on String {
  bool get containsUppercase => contains(RegExp(r'[A-Z]'));
  bool get containsLowercase => contains(RegExp(r'[a-z]'));
  bool get containsNumber => contains(RegExp(r'[0-9]'));
}
