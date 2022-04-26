part of 'client_bloc.dart';

abstract class ClientState {

}

class ClientPage extends ClientState{}

class DeletionDone extends ClientState {
  final int idClient;

  DeletionDone({required this.idClient});
}