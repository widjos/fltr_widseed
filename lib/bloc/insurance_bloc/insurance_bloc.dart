


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test/model/insurance/insurance_list.dart';

part 'insurance_event.dart';

part 'insurance_state.dart';

class InsuranceBloc extends Bloc<InsuranceEvent, InsuranceState>{
  InsuranceBloc(): super(InsurancePage()){
     
     on<UpdateInsurance>(((event, emit) {
       emit(OpenFormUpdate(data: event.data));
     }));

  }
}