import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/provider/client_provider.dart';
import 'package:test/repository/cliente_repository.dart';

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

    on<AuthFingerPrint>((event, emit) async {
           final isAutho = await event.authenticate();
           SharedPreferences prefs = await SharedPreferences.getInstance();
          
    });

    on<LoginSpring>((event, emit) async {
      var url = Uri.http("10.0.2.2:9595", "/cliente/buscar/email/password",
          {'email': event.email, 'password': event.pass});

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        final body = json.decode(response.body);

        return emit(LoginDone(email: body['email'], pass: '444'));
      } else {
        print('Request failed with status: ${response.statusCode}.');
        return emit(WrongCredentials());
      }
    });

    on<ShowMensaje>(((event, emit) {
      emit(AuthLocalError(mensaje: event.mensaje));
    }));

   on<LoginDb>((event, emit) async  {
     print(await ClienteRepository.shared.showTable(table: 'cliente')); 
     dynamic result = await ClientProvider.shared.logInDb(event.email, event.pass);
     result.isEmpty  ? emit(WrongCredentials()) :  emit(LoginDone(email: 'prueba', pass: '444'));

   }); 

    on<LogOut>(((event, emit) async {
      dynamic resp = await ClientProvider.shared.logOutClientApi();
      emit(LogoutDone(code: resp));
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
