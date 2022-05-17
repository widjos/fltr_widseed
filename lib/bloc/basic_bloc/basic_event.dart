part of 'basic_bloc.dart';

abstract class BasicEvent extends Equatable {
  const BasicEvent();
}

class ButtonPressed extends BasicEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class ToClients extends BasicEvent {
  @override

  List<Object?> get props => throw UnimplementedError();
}

class ToSinister extends BasicEvent {
  @override

  List<Object?> get props => throw UnimplementedError();
}

class ToInsurance extends BasicEvent {
  @override

  List<Object?> get props => throw UnimplementedError();
}

class LoginBegin extends BasicEvent {
  final String email;
  final String pass;

  LoginBegin({required this.email, required this.pass});

  @override
  List<Object?> get props => [email, pass];
}

class ShowMensaje extends BasicEvent{
  final String mensaje;

ShowMensaje({required this.mensaje});
  @override

  List<Object?> get props =>[mensaje];
  
}

class LogOut extends BasicEvent {

  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginSpring extends BasicEvent {
  final String email;
  final String pass;

  LoginSpring({required this.email, required this.pass});

  @override
  List<Object?> get props => [email, pass];
}

class AuthFingerPrint extends BasicEvent {
    static final _auth = LocalAuthentication();

    Future<bool> authenticate() async {
    final isAvalible = await hasBiometrics();
    if (!isAvalible) return false;
    try {
      return await _auth.authenticate(
        localizedReason: 'Escaner de la huella dactilar',
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
      );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }


    static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

  @override

  List<Object?> get props => throw UnimplementedError();

}

class LoginDb extends BasicEvent {
  final String email;
  final String pass;

  LoginDb({required this.email, required this.pass});

  @override
  List<Object?> get props => [email, pass];
}


class EmailInvalid extends BasicEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
