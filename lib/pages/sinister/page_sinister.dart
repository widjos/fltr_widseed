import 'package:flutter/material.dart';
import 'package:test/model/sinister/sinister_list.dart';
import 'package:test/pages/sinister/form_delete_sinister.dart';
import 'package:test/pages/sinister/show_sinister.dart';
import 'package:test/provider/sinister_provider.dart';
import 'package:test/widgets/button_icon.dart';
import 'package:test/widgets/row_data.dart';

class PageSinister extends StatefulWidget {
  PageSinister({Key? key}) : super(key: key);

  @override
  State<PageSinister> createState() => _PageSinisterState();
}

class _PageSinisterState extends State<PageSinister> {
  late SinisterList siniestroList;
  var list = [];

  @override
  void initState() {
    super.initState();
  }

  Future refreshData() async {
    List<Sinister> data = await SinisterProvider.shared.getAllDb(context);

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
          title: Row(
            children: [
              const Text('Siniestro'),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    SinisterProvider.shared.addColumn(column: 'prueba', typeIn: 'TEXT');
                    },
                  icon: const Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                    size: 30,
                  ))
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: FutureBuilder(
          future: SinisterProvider.shared.getAllDb(context),
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
                  final List sinisterList =
                      snapshot.requireData as List<Sinister>;
                  if (sinisterList.isNotEmpty) {
                    list = sinisterList;
                  }
                  return RefreshIndicator(
                    onRefresh: refreshData,
                    child: ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              ExpansionTile(
                                title: RowData(
                                  idData1: 'Id:',
                                  valueData1: list[index].id.toString(),
                                  idData2: 'Fecha:',
                                  valueData2: list[index].fechaSiniestro,
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
                                                return ShowSinister(
                                                    siniestro: list[index]);
                                              });
                                        }),
                                        ButtonIcon(true, Icons.delete, 20,
                                            Theme.of(context).primaryColor, () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return FormDeleteSinister(
                                                    idSiniestro: list[index].id
                                                    
                                          );}).then((value) => {refreshData()});
                                        }),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        }),
                  );
                } else {
                  return Container();
                }
            }
          },
        ));
  }
}
