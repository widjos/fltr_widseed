import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:test/model/client/client.dart';
import 'package:http/http.dart' as http;

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

    on<LoginSpring>((event, emit) async {
      var url = Uri.http("10.0.2.2:9595", "/cliente/buscar/email/password",
          {'email': event.email, 'password': event.pass});

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        final body = json.decode(response.body);
        final client = Client.fromService(body,response);

        print('Number of books about http: ${client.email}');
        return emit(LoginDone(email: client.email, pass: client.password));
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return emit(WrongCredentials());
      }
    });

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
