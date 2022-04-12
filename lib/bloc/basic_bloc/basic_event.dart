part of 'basic_bloc.dart';

abstract  class BasicEvent extends Equatable{
  const  BasicEvent();
}

class ButtonPressed extends BasicEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}


class LoginBegin extends BasicEvent{
  final String email;
  final String pass;

  LoginBegin({required this.email, required this.pass});

  @override
  List<Object?> get props => [email,pass];
}

class EmailInvalid extends BasicEvent{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}