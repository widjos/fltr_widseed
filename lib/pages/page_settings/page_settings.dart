import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/prefs/style.dart';
import 'package:test/prefs/theme_provider.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/util/app_strings.dart';
import 'package:test/widgets/gradient_back.dart';

class PageSettings extends StatefulWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  State<PageSettings> createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
    bool switchValue = false;
    ThemeProvider themeProvider = ThemeProvider();


  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    

    final items = ['English', 'Español'];
    return Scaffold(
        appBar: AppBar(
           backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            children: [
              Text(localization.dictionary(LabelsText.settingsTitle)),
              
            ],
          ),
        ),
        body: Stack(
          children: [
            GradientBack(tittle: 'Settings'),
            Container(
              padding: const EdgeInsets.only(top: 120),
              child: Center(
              child: Column(
                children: [
                  Container(
                    padding:  const EdgeInsets.only(left: 50, top:20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right:25),
                          child: const Icon(
                            Icons.abc_outlined,
                            size: 50,
                            color: Colors.white,
                          )
                        ),
                        Text(
                          localization.dictionary(LabelsText.settingsLanguage),
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 30),
                          child: DropdownButton<String>(
                          
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (value){
                              setState(() {
                                changeLang(value, context);
                              });
                          },
                        ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding:  const EdgeInsets.only(left: 50, top:20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right:25),
                          child: const Icon(
                            Icons.palette,
                            size: 50,
                            color: Colors.white,
                          )
                        ),
                        Text(
                          localization.dictionary(LabelsText.settingsTheme),
                          style: Theme.of(context).textTheme.bodyText1
                        ),
                        
                            Container(
                                child: Switch(
                                    value: switchValue,
                                    onChanged: (val) async {
                                      DatabaseReference ref = FirebaseDatabase
                                          .instance
                                          .ref('preferences');

                                      themeProvider.darkTheme =
                                          !themeProvider.darkTheme;
                                      await ref.update(
                                          {'theme': themeProvider.darkTheme});
                                      setState(() {
                                        switchValue = val;
                                      });
                                    }))
                      ],
                    ),
                  )

                ],
              ),
            ),
            )
          ],
        ));


  }


  void changeLang(value, BuildContext context) async {
    Locale locale = await LanguageProvider().getDefaultLanguage();
    switch (value) {
      case 'Ingles':
      case 'English':
        locale = const Locale("en");
        break;
      case 'Español':
      case 'Spanish':
        locale = const Locale("es");
        break;
    }

    final langChange = Provider.of<LanguageProvider>(context, listen: false);
    langChange.setLaguaje = locale;
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: Theme.of(context).textTheme.bodyText1,
    )
    );
}
