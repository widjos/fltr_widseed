part of 'insurance_bloc.dart';

abstract class InsuranceEvent extends Equatable {
  const InsuranceEvent();
}

class UpdateInsurance extends InsuranceEvent {
  Insurance data;

  UpdateInsurance({required this.data});

  @override
  List<Object?> get props => [data]; 
}