import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test/provider/client_provider.dart';

part 'client_event.dart';

part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {

  ClientBloc() : super(ClientPage()){

    on<DeleteClient>((event, emit) {
      ClientProvider.shared.deleteClient(event.idClient);
      emit(DeletionDone(idClient: event.idClient));
    });
  }
    
}