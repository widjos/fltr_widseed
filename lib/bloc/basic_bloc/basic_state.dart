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

class WrongCredentials extends BasicState{}

class EmailNotValid extends BasicState{}