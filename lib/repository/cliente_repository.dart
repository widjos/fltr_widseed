import 'package:test/repository/master_repository.dart';

class ClienteRepository extends MasterRepository {
  ClienteRepository._privateContructor();
  static final MasterRepository shared = ClienteRepository._privateContructor();
}