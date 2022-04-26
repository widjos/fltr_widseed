part of 'insurance_bloc.dart';

abstract class InsuranceState {}

class InsurancePage extends InsuranceState{}

class OpenFormUpdate extends InsuranceState{

  Insurance data;

  OpenFormUpdate({required this.data});
}