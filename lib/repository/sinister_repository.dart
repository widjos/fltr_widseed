import 'package:test/repository/master_repository.dart';

class SinisterRepository extends MasterRepository{
  SinisterRepository._privateConstructor();
  static final MasterRepository shared = SinisterRepository._privateConstructor();
}