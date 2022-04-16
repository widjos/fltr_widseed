import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

part 'basic_state.dart';
part 'basic_event.dart';

class BasicBloc extends Bloc<BasicEvent, BasicState> {
  BasicBloc() : super(AppStarted()) {
    on<ButtonPressed>((event, emit) {
      emit(PageChanged(title: "Hola Mundo"));
    });

    on<LoginBegin>(((event, emit) {
      event.email == FirebaseRemoteConfig.instance.getString('email') &&
              event.pass == FirebaseRemoteConfig.instance.getString('pass')
          ? emit(LoginDone(email: event.email, pass: event.pass))
          : emit(WrongCredentials());
    }));

    on<EmailInvalid>(((event, emit) {
      emit(EmailNotValid());
    }));

    on<ToClients>((event, emit) {
      emit(ClientsPage());
    });

    on<ToInsurance>((event, emit) {
      emit(InsurancePage());
    });

    on<ToSinister>((event, emit) {
      emit(SinisterPage());
    });
  }
}
