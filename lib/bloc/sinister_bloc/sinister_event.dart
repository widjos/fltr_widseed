part of 'sinister_bloc.dart';

abstract class SinisterEvent extends Equatable {
  const SinisterEvent();
}


class DeleteSinister extends SinisterEvent {
  
  final int idSinister;
  BuildContext contexto;
  DeleteSinister({required this.idSinister, required this.contexto,});

  @override
  List<Object?> get props => [idSinister, contexto, ];

}