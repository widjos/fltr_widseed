import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';
import 'package:test/bloc/client_bloc/client_bloc.dart';
import 'package:test/model/client/client_list.dart';
import 'package:test/pages/clients/form_cliente.dart';
import 'package:test/pages/clients/show_client.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/provider/client_provider.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/util/app_strings.dart';

import 'package:test/widgets/button_icon.dart';
import 'package:test/widgets/gradient_back.dart';
import 'package:test/widgets/row_data.dart';

class PageClients extends StatefulWidget {
  bool theme;

  PageClients({Key? key, required this.theme}) : super(key: key);

  @override
  State<PageClients> createState() => _PageClientsState();
}

class _PageClientsState extends State<PageClients> {
  late Future dataLoad;
  var list = [];

  @override
  void initState() {
    super.initState();
  }

  Future _getData() async {
    List<Client> data = await ClientProvider.shared.getAllDb(context);

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
    final lang = Provider.of<LanguageProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    return BlocProvider(
      create: (BuildContext context) => ClientBloc(),
      child: BlocListener<ClientBloc, ClientState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ClientPage:
              break;
            case DeletionDone:
              final user = state as DeletionDone;
              ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('${localization.dictionary(LabelsText.clientDeleteRegister)} = ${user.idClient}')));
              break;
          }
        },
        child: BlocBuilder<ClientBloc, ClientState>(builder: (context, state) {
          return Stack(
            children: [
              GradientBack(tittle: ''),
              Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: Row(
                      children: [
                        Text(localization.dictionary(LabelsText.clientTittle)),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return FormClient(llamada: () {
                                      _getData();
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar( SnackBar(
                                              content: Text(localization.dictionary(LabelsText.clientNewRegister))));
                                    });
                                  });
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.white,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                  body: FutureBuilder(
                    future: ClientProvider.shared.getAllDb(context),
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
                            final List clientList =
                                snapshot.requireData as List<Client>;
                            if (clientList.isNotEmpty) {
                              list = clientList;
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
                                          idData1: 'Id:',
                                          valueData1: list[index].id.toString(),
                                          idData2: localization.dictionary(LabelsText.clientEmail),
                                          valueData2: list[index].email,
                                        ),
                                        iconColor: Theme.of(context)
                                            .toggleableActiveColor,
                                        collapsedIconColor: Theme.of(context)
                                            .toggleableActiveColor,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10, bottom: 15),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                ButtonIcon(
                                                    true,
                                                    Icons
                                                        .mark_chat_unread_sharp,
                                                    20,
                                                    Colors.green, () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return ShowClient(
                                                            cliente:
                                                                list[index]);
                                                      });
                                                }),
                                                ButtonIcon(true, Icons.delete,
                                                    20, Colors.green, () {
                                                  BlocProvider.of<ClientBloc>(
                                                          context)
                                                      .add(DeleteClient(
                                                          idClient:
                                                              list[index].id));
                                                  _getData();
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
                  ))
            ],
          );
        }),
      ),
    );
  }
}
