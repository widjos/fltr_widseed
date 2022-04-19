import 'package:flutter/material.dart';
import 'package:test/model/insurance/insurance_list.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';
import 'package:test/widgets/api_item.dart';

class PageInsurance extends StatelessWidget {
  const PageInsurance({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text('Seguros'), 
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
                  final InsuranceList seguroList = snapshot.requireData as InsuranceList;
                    return PageView.builder(
                      itemCount: seguroList.seguros.length,
                      itemBuilder: (BuildContext context, int index){
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            Column(
                              children: [
                                ApiItem(maxHeight: 50, fontSize: 20, name: 'Numero Poliza', value: seguroList.seguros[index].numeroPoliza.toString()),
                                ApiItem(maxHeight: 50, fontSize: 20, name: 'Ramo', value: seguroList.seguros[index].ramo),
                                ApiItem(maxHeight: 50, fontSize: 20, name: 'Fecha Inicio', value: seguroList.seguros[index].fechaInicio),
                                ApiItem(maxHeight: 50, fontSize: 20, name: 'Fecha Vencimiento', value: seguroList.seguros[index].fechaVencimiento),
                                ApiItem(maxHeight: 50, fontSize: 20, name: 'Cond Particular', value: seguroList.seguros[index].condicionesParticulares),
                                ApiItem(maxHeight: 50, fontSize: 20, name: 'Observaciones', value: seguroList.seguros[index].observaciones),
                                ApiItem(maxHeight: 50, fontSize: 20, name: 'Dni Cliente', value: seguroList.seguros[index].dniCl.toString()),
                              ],
                            )
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