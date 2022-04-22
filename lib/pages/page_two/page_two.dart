import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';
import 'package:test/model/client/client_list.dart';
import 'package:test/model/sinister/sinister_list.dart';
import 'package:test/pages/clients/page_clients.dart';
import 'package:test/pages/insurance/page_insurance.dart';
import 'package:test/pages/page_two/card_button.dart';
import 'package:test/pages/sinister/page_sinister.dart';
import 'package:test/provider/api_manager.dart';
import 'package:test/repository/cliente_repository.dart';
import 'package:test/repository/db_manager.dart';
import 'package:test/repository/sinister_repository.dart';
import 'package:test/util/app_type.dart';
import 'package:test/util/model_type.dart';

class PageTwo extends StatefulWidget {
  final String tittle;
  bool theme;
  PageTwo({required this.tittle, required this.theme, Key? key})
      : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  void initState() {
    loadDataLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

    return BlocProvider(
      create: (BuildContext context) => BasicBloc(),
      child: BlocListener<BasicBloc, BasicState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ClientsPage:
              final estado = state as ClientsPage;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => PageClients(theme: widget.theme)));
              break;
            case SinisterPage:
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => PageSinister()));
              break;

            case InsurancePage:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => PageInsurance(theme: widget.theme)));
              break;
          }
        },
        child: BlocBuilder<BasicBloc, BasicState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor:
                      widget.theme ? Colors.black : Colors.green[700],
                  title: const Text('Bienvenido'),
                ),
                body: ListView(
                  padding: const EdgeInsets.only(top: 10),
                  children: [
                    LimitedBox(
                      maxHeight: 100,
                      child: Container(
                        padding: const EdgeInsets.only(top: 20, left: 20),
                        child: Center(
                          child: Container(
                            child: Row(
                              children: [
                                const Icon(Icons.account_box_rounded, size: 40),
                                Text(
                                  widget.tittle,
                                  style: Theme.of(context).textTheme.bodyText1,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    CardButton(
                        textDescription: 'Seguro',
                        onPressed: () {
                          BlocProvider.of<BasicBloc>(context)
                              .add(ToInsurance());
                        },
                        picture: 'assets/img/seguro.jpg'),
                    const Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 5,
                      indent: 60,
                      endIndent: 60,
                    ),
                    CardButton(
                        textDescription: 'Cliente',
                        onPressed: () {
                          BlocProvider.of<BasicBloc>(context).add(ToClients());
                        },
                        picture: 'assets/img/cliente.jpg'),
                    const Divider(
                      color: Colors.grey,
                      height: 20,
                      thickness: 5,
                      indent: 60,
                      endIndent: 60,
                    ),
                    CardButton(
                        textDescription: 'Siniestro',
                        onPressed: () {
                          BlocProvider.of<BasicBloc>(context).add(ToSinister());
                        },
                        picture: 'assets/img/siniestro.jpg')
                  ],
                ));
          },
        ),
      ),
    );
  }

  void loadDataLocal() async {
    ClientList dataCl = await ApiManager.shared.request(
        baseUrl: "10.0.2.2:9595",
        pathUrl: "/cliente/buscar",
        type: HttpType.GET,
        modelType: ModelType.CLIENT) as ClientList;

    SinisterList dataSn = await ApiManager.shared.request(
        baseUrl: "10.0.2.2:9595",
        pathUrl: "/siniestro/buscar",
        type: HttpType.GET,
        modelType: ModelType.SINISTER) as SinisterList;

    ClienteRepository.shared.save(data: dataCl.clientes, tableName: 'cliente');
    SinisterRepository.shared.save(data: dataSn.siniestros, tableName: 'siniestro');

    List listTemp =  await SinisterRepository.shared.selectAll(tableName: 'siniestro');
    listTemp.forEach((element) {
      print(element);
    });
  }
}
