class InsuranceList {
  late List<Insurance> seguros = [];

  InsuranceList.fromService(List<dynamic> data) {
    for (var element in data) {
      seguros.add(Insurance.fromService(element));
    }
  }

  InsuranceList.fromDb(List<dynamic> data) {
    for (var element in data) {
      seguros.add(Insurance.fromDb(element));
    }
  }
}

class Insurance {
  late int? id;
  late int numeroPoliza;
  late String ramo;
  late String fechaInicio;
  late String fechaVencimiento;
  late String condicionesParticulares;
  late String observaciones;
  late int dniCl;

  Insurance.fromService(Map<String, dynamic> data) {
    numeroPoliza = data['numeroPoliza'];
    ramo = data['ramo'];
    fechaInicio = data['fechaInicio'];
    fechaVencimiento = data['fechaVencimiento'];
    condicionesParticulares = data['condicionesParticulares'];
    observaciones = data['observaciones'];
    dniCl = data['dniCl'];
  }

  Insurance.fromDb(Map<String, dynamic> data) {
    id = data['id'];
    ramo = data['ramo'];
    fechaInicio = data['fechaInicio'];
    fechaVencimiento = data['fechaVencimiento'];
    condicionesParticulares = data['condicionesParticulares'];
    observaciones = data['observaciones'];
    dniCl = data['dniCl'];
  }

  Insurance.toDb(Map<String, dynamic> data) {
    ramo = data['ramo'];
    fechaInicio = data['fechaInicio'];
    fechaVencimiento = data['fechaVencimiento'];
    condicionesParticulares = data['condicionesParticulares'];
    observaciones = data['observaciones'];
    dniCl = data['dniCl'];
  }

  Map<String, dynamic> toDatabase() => {
        'ramo': ramo,
        'fechaInicio': fechaInicio,
        'fechaVencimiento': fechaVencimiento,
        'condicionesParticulares': condicionesParticulares,
        'observaciones': observaciones,
        'dniCl': dniCl
      };
}
