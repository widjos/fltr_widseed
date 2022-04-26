part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();
}


class DeleteClient extends ClientEvent {
  
  final int idClient;
  const DeleteClient({required this.idClient});

  @override
  List<Object?> get props => [idClient];

}

