import 'package:flutter/material.dart';
import 'package:test/model/insurance/insurance_list.dart';
import 'package:test/pages/insurance/form_insurance.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';
import 'package:test/widgets/api_item.dart';
import 'package:test/widgets/button_icon.dart';
import 'package:test/widgets/row_data.dart';

class PageInsurance extends StatefulWidget {

  bool theme;
  PageInsurance({ Key? key, required this.theme }) : super(key: key);

  @override
  State<PageInsurance> createState() => _PageInsuranceState();
}

class _PageInsuranceState extends State<PageInsurance> {

  late Future dataLoad;
  var list =[];

  @override
  void initState(){
    super.initState();
  }

  Future _getData() async {
    InsuranceList data = await ApiManager.shared.request(baseUrl: "10.0.2.2:9595", pathUrl: "/seguro/buscar", type: HttpType.GET, modelType: ModelType.INSURANSE) as InsuranceList;

    if(data.seguros.isNotEmpty){
      setState(() {
        data.seguros.forEach((element) {list.add(element);});
      });
    }
        
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('Seguros'),
       backgroundColor: widget.theme ? Colors.black :  Colors.green[700],
           
      ),
      body: FutureBuilder(
        future: ApiManager.shared.request(baseUrl: "10.0.2.2:9595", pathUrl: "/seguro/buscar", type: HttpType.GET, modelType: ModelType.INSURANSE),
        builder: (BuildContext context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.done:
            case ConnectionState.active:
                if(snapshot.hasData){
                  InsuranceList seguroList = snapshot.requireData as InsuranceList;
                  if(seguroList.seguros.isNotEmpty){
                    list = seguroList.seguros;
                  }
                    return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                      color: Theme.of(context).primaryColor,
                      ),
                      itemCount: seguroList.seguros.length,
                      itemBuilder: (BuildContext context, int index){
                        return 
                            Column(
                              children: [

                                RowData(idData1: 'Numero Poliza:', valueData1: list[index].numeroPoliza.toString(), idData2: 'Fecha Inicio:', valueData2: list[index].fechaInicio, myButton: 
                              ButtonIcon(true, Icons.update, 20, Colors.green, (){

                                showDialog(
                                  context: context, 
                                  builder: (BuildContext context){
                                    return FormInsurance(
                                      numPoliza: list[index].numeroPoliza, 
                                      ramo: list[index].ramo, 
                                      fechaInicio: list[index].fechaInicio, 
                                      fechaFinal: list[index].fechaVencimiento, 
                                      condParticulares: list[index].condicionesParticulares, 
                                      observaciones: list[index].observaciones, 
                                      dniCl: list[index].dniCl, 
                                      llamada: (){
                                        _getData();
                                        Navigator.pop(context);
                                      });
                                  } );
                               
                              }),)
                                //ApiItem(maxHeight: 50, fontSize: 20, name: 'Numero Poliza', value: seguroList.seguros[index].numeroPoliza.toString()),
                                //ApiItem(maxHeight: 50, fontSize: 20, name: 'Ramo', value: seguroList.seguros[index].ramo),
                                //ApiItem(maxHeight: 50, fontSize: 20, name: 'Fecha Inicio', value: seguroList.seguros[index].fechaInicio),
                                //ApiItem(maxHeight: 50, fontSize: 20, name: 'Fecha Vencimiento', value: seguroList.seguros[index].fechaVencimiento),
                                //ApiItem(maxHeight: 50, fontSize: 20, name: 'Cond Particular', value: seguroList.seguros[index].condicionesParticulares),
                                //ApiItem(maxHeight: 50, fontSize: 20, name: 'Observaciones', value: seguroList.seguros[index].observaciones),
                                //ApiItem(maxHeight: 50, fontSize: 20, name: 'Dni Cliente', value: seguroList.seguros[index].dniCl.toString()),
                              ],
                            );
                          
                      }
                      );
                  }
                  else{
                    return  Container();
                  }
          }
        },
      )
    );
  }
}