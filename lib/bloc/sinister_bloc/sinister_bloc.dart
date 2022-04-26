import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'sinister_event.dart';
part 'sinister_state.dart';

class SinisterBloc extends Bloc<SinisterEvent, SinisterState> {
  SinisterBloc() : super(SinisterPage()) {
    on<DeleteSinister>((event, emit) {
       emit(DeletionDone(idSinister: event.idSinister));    //.then((value) => {refreshData()});
    });
  }
}
