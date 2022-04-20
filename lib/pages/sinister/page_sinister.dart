import 'package:flutter/material.dart';
import 'package:test/model/sinister/sinister_list.dart';
import 'package:test/pages/sinister/form_delete_sinister.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';
import 'package:test/widgets/api_item.dart';
import 'package:test/widgets/button_icon.dart';

class PageSinister extends StatelessWidget {
  const PageSinister({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siniestro'),
      ),
      body: FutureBuilder(
        future: ApiManager.shared.request(baseUrl: "10.0.2.2:9595", pathUrl: "/siniestro/buscar", type: HttpType.GET, modelType: ModelType.SINISTER),
        builder: (BuildContext context, snapshot){
          switch(snapshot.connectionState){
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
                final  SinisterList siniestroList = snapshot.requireData as SinisterList;
                  return PageView.builder(
                    itemCount: siniestroList.siniestros.length,
                    itemBuilder: (BuildContext context, int index){
                      return ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            children: [
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Id Siniestro', value: siniestroList.siniestros[index].idSiniestro.toString()),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Fecha', value: siniestroList.siniestros[index].fechaSiniestro),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Causa', value: siniestroList.siniestros[index].causas),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Aceptado', value: siniestroList.siniestros[index].aceptado),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Indenmizacion', value: siniestroList.siniestros[index].indenmizacion),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Numero Poliza', value: siniestroList.siniestros[index].numeroPoliza.toString()),
                              ApiItem(maxHeight: 50, fontSize: 20, name: 'Perito', value: siniestroList.siniestros[index].dniPerito.toString()),
                              
                            ],
                            
                          ),
                          ButtonIcon(true, Icons.delete, 20, Colors.amber, (){
                                showDialog(
                                  context: context, 
                                  builder: (BuildContext context){
                                    return FormDeleteSinister(idSiniestro: siniestroList.siniestros[index].idSiniestro);
                                  });
                              })
                        ],
                      );
                    }
                    );
              }else{
                return Container();
              } 
          }
        },
      )
      
    );
  }
}