part of 'basic_bloc.dart';

abstract class BasicState {

}

class AppStarted extends BasicState{}

class PageChanged extends BasicState{
  final String title;

  PageChanged({required this.title});
  
}

class LoginDone extends BasicState{
  final String email;
  final String pass;

  LoginDone({required this.email, required this.pass});
}

class LoginDbDone extends BasicState {
  final String email;
  final String pass;

  LoginDbDone({required this.email, required this.pass});
}

class LogoutDone extends BasicState{

  dynamic code;

  LogoutDone({required this.code});
}

class AuthLocalError extends BasicState{

  final String mensaje;

  AuthLocalError({required this.mensaje});
}

class WrongCredentials extends BasicState{}

class EmailNotValid extends BasicState{}

class ClientsPage extends BasicState {}

class InsurancePage extends BasicState {}

class SinisterPage extends BasicState{}