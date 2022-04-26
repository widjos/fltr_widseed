part of 'sinister_bloc.dart';

abstract class SinisterState {

}

class SinisterPage extends SinisterState{}

class DeletionDone extends SinisterState {
  final int idSinister;

  DeletionDone({required this.idSinister});
}