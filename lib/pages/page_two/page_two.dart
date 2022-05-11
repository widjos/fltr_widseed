import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test/bloc/basic_bloc/basic_bloc.dart';
import 'package:test/main.dart';
import 'package:test/pages/clients/page_clients.dart';
import 'package:test/pages/insurance/page_insurance.dart';
import 'package:test/pages/page_one/page_one.dart';
import 'package:test/pages/page_settings/page_settings.dart';
import 'package:test/pages/page_two/card_button.dart';
import 'package:test/pages/sinister/page_sinister.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/util/app_strings.dart';
import 'package:test/widgets/gradient_back.dart';

class PageTwo extends StatefulWidget {
  final String tittle;
  bool theme;

  PageTwo({required this.tittle, required this.theme, Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  void initState() {
    // loadDataLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;

    return BlocProvider(
      create: (BuildContext context) => BasicBloc(),
      child: BlocListener<BasicBloc, BasicState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ClientsPage:
              final estado = state as ClientsPage;
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => PageClients(theme: widget.theme)));
              break;
            case SinisterPage:
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => PageSinister()));
              break;

            case InsurancePage:
              Navigator.push(context, MaterialPageRoute(builder: (ctx) => PageInsurance(theme: widget.theme)));
              break;

            case LogoutDone:
              final resp = state as LogoutDone;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => PageOne(theme: widget.theme)));
              
           
              break; 
          }
        },
        child: BlocBuilder<BasicBloc, BasicState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                  title: Row(
                    children: [
                      Text(localization.dictionary(LabelsText.homePageTittle)),
                      const Spacer(),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => const PageSettings()));
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30,
                      )),
                      IconButton(
                        onPressed: (){
                          BlocProvider.of<BasicBloc>(context).add(LogOut());
                      },
                        icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30,
                      ))

                    ],
                  ),
                ),
                body: Stack(
                  children: [
                    GradientBack(tittle: ''),
                    ListView(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
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
                        textDescription: localization.dictionary(LabelsText.homePageInsurance),
                        onPressed: () {
                          BlocProvider.of<BasicBloc>(context).add(ToInsurance());
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
                        textDescription: localization.dictionary(LabelsText.homePageClient),
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
                        textDescription: localization.dictionary(LabelsText.homePageSinister),
                        onPressed: () {
                          BlocProvider.of<BasicBloc>(context).add(ToSinister());
                        },
                        picture: 'assets/img/siniestro.jpg')
                  ],
                )
                  ],
                ));
          },
        ),
      ),
    );
  }

}
