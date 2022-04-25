import 'package:flutter/material.dart';
import 'package:test/model/insurance/insurance_list.dart';
import 'package:test/pages/insurance/form_insurance.dart';
import 'package:test/pages/insurance/show_insurance.dart';
import 'package:test/provider/insurance_provider.dart';
import 'package:test/widgets/button_icon.dart';
import 'package:test/widgets/row_data.dart';

class PageInsurance extends StatefulWidget {
  bool theme;
  PageInsurance({Key? key, required this.theme}) : super(key: key);

  @override
  State<PageInsurance> createState() => _PageInsuranceState();
}

class _PageInsuranceState extends State<PageInsurance> {
  late Future dataLoad;
  var list = [];

  @override
  void initState() {
    super.initState();
  }

  Future _getData() async {
    List<Insurance> data = await InsuranceProvider.shared.getAllDb(context);
    if (data.isNotEmpty) {
      setState(() {
        for (var element in data) {
          list.add(element);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Seguros'),
            backgroundColor: Theme.of(context).primaryColor),
        body: FutureBuilder(
          future: InsuranceProvider.shared.getAllDb(context),
          builder: (BuildContext context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case ConnectionState.done:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final List insuranceList =
                      snapshot.requireData as List<Insurance>;
                  if (insuranceList.isNotEmpty) {
                    list = insuranceList;
                  }
                  return ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            color: Theme.of(context).primaryColor,
                          ),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ExpansionTile(
                              title: RowData(
                                idData1: 'Numero Poliza:',
                                valueData1: list[index].id.toString(),
                                idData2: 'Fecha Inicio:',
                                valueData2: list[index].fechaInicio,
                              ),
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ButtonIcon(
                                          true, Icons.info, 20, Colors.green,
                                          () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ShowInsurance(
                                                  seguro: list[index]);
                                            });
                                      }),
                                      ButtonIcon(
                                          true, Icons.update, 20, Colors.green,
                                          () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return FormInsurance(
                                                numPoliza: list[index].id,
                                                ramo: list[index].ramo,
                                                fechaInicio:
                                                    list[index].fechaInicio,
                                                fechaFinal: list[index]
                                                    .fechaVencimiento,
                                                condParticulares: list[index]
                                                    .condicionesParticulares,
                                                observaciones:
                                                    list[index].observaciones,
                                                dniCl: list[index].dniCl,
                                              );
                                            }).then((value) => {_getData()});
                                      })
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      });
                } else {
                  return Container();
                }
            }
          },
        ));
  }
}
