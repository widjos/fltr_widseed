import 'package:test/repository/master_repository.dart';

class InsuranceRepository extends MasterRepository{
  InsuranceRepository._privateConstructor();
  static final MasterRepository shared = InsuranceRepository._privateConstructor();
}