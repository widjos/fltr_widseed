
class Insurance {
  
  late int numeroPoliza;
  late String ramo;
  late String fechaInicio;
  late String fechaVencimiento;
  late String condicionesParticulares;
  late String observaciones;
  late int dniCl; 


  Insurance(dynamic data){
    numeroPoliza = data['numeroPoliza'];
    ramo = data['ramo'];
    fechaInicio = data['fechaInicio'];
    fechaVencimiento = data['fechaVencimiento'];
    condicionesParticulares = data['condicionesParticulares'];
    observaciones = data['observaciones'];
    dniCl = data['dniCl'];
  }

}

