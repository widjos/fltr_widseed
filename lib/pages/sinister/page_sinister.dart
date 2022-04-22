import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:test/model/insurance/insurance.dart';
import 'package:test/model/insurance/insurance_list.dart';
import 'package:test/model/sinister/sinister_list.dart';
import 'package:test/pages/sinister/form_delete_sinister.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/repository/sinister_repository.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';
import 'package:test/widgets/api_item.dart';
import 'package:test/widgets/button_icon.dart';
import 'package:test/widgets/row_data.dart';

class PageSinister extends StatefulWidget {


  PageSinister({ Key? key }) : super(key: key);

  @override
  State<PageSinister> createState() => _PageSinisterState();
}

class _PageSinisterState extends State<PageSinister> {
 late SinisterList siniestroList;
 var list = [];

  @override
  void initState(){
    super.initState();
  }

  Future refreshData() async {
   SinisterList data = await
    ApiManager.shared.request(
      baseUrl: "10.0.2.2:9595", 
      pathUrl: "/siniestro/buscar", 
      type: HttpType.GET, 
      modelType: ModelType.SINISTER) as SinisterList;

      if(data.siniestros.isNotEmpty){
        setState(() {
          data.siniestros.forEach((element) { list.add(element);});
        });
      }

      /*List listTemp = await SinisterRepository.shared.selectAll(tableName: 'siniestro');
      if(listTemp.isNotEmpty){
        setState(() {
          listTemp.forEach((element) {list.add(element);});
        });
      }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Siniestro'),
        backgroundColor: Theme.of(context).primaryColor,
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
                siniestroList = snapshot.requireData as SinisterList;
                if(siniestroList.siniestros.isNotEmpty){
                  list = siniestroList.siniestros;
                }
                  return RefreshIndicator( 
                    onRefresh: refreshData,
                    child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                      color: Theme.of(context).primaryColor,
                    ),
                    itemCount: siniestroList.siniestros.length,
                    itemBuilder: (BuildContext context, int index){
                      return 
                          Column(
                            children: [
                              RowData(idData1: 'Id:', valueData1: list[index].idSiniestro.toString(), idData2: 'Fecha:', valueData2: list[index].fechaSiniestro, myButton: 
                              ButtonIcon(true, Icons.delete, 20, Theme.of(context).primaryColor, (){

                                showDialog(
                                  context: context, 
                                  builder: (BuildContext context){
                                    return FormDeleteSinister(idSiniestro: list[index].idSiniestro, llamada: (){
                                      
                                      Navigator.pop(context);
                                    });
                                  }).then((value) => {refreshData()});
                              }),)
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Id Siniestro', value: siniestroList.siniestros[index].idSiniestro.toString()),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Fecha', value: siniestroList.siniestros[index].fechaSiniestro),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Causa', value: siniestroList.siniestros[index].causas),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Aceptado', value: siniestroList.siniestros[index].aceptado),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Indenmizacion', value: siniestroList.siniestros[index].indenmizacion),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Numero Poliza', value: siniestroList.siniestros[index].numeroPoliza.toString()),
                              //ApiItem(maxHeight: 50, fontSize: 20, name: 'Perito', value: siniestroList.siniestros[index].dniPerito.toString()),
                              
                            ],
                            
                          );
                          /*ButtonIcon(true, Icons.delete, 20, Colors.amber, (){
                                showDialog(
                                  context: context, 
                                  builder: (BuildContext context){
                                    return FormDeleteSinister(idSiniestro: siniestroList.siniestros[index].idSiniestro);
                                  });
                              })*/
                     
                    }
                    ),
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