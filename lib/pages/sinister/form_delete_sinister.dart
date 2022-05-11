import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/provider/sinister_provider.dart';
import 'package:test/util/app_strings.dart';

class FormDeleteSinister extends StatefulWidget {
  int idSiniestro;
  //bool _idValidate = false;

  FormDeleteSinister({Key? key, required this.idSiniestro}) : super(key: key);

  @override
  State<FormDeleteSinister> createState() => _FormDeleteSinisterState();
}

class _FormDeleteSinisterState extends State<FormDeleteSinister> {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    

    return AlertDialog(
      title:  Text(localization.dictionary(LabelsText.sinisterDoYouWantDelete)),
      actions: [
        TextButton(
            onPressed: () {
              SinisterProvider.shared.deleteSinister(widget.idSiniestro);
              Navigator.pop(context);
            },
            child:  Text(localization.dictionary(LabelsText.formDelete))),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child:  Text(localization.dictionary(LabelsText.formCancel)))
      ],
    );
  }
}
