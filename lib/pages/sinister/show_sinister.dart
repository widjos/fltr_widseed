import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/model/sinister/sinister_list.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/util/app_strings.dart';

class ShowSinister extends StatelessWidget {
  
  Sinister siniestro;
  
  ShowSinister({ Key? key , required this.siniestro }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    

    return AlertDialog(
      title:   Text(localization.dictionary(LabelsText.information)),
      content: Form(
        child: Container(
          height: 400,
          width: 400,
          child: ListView(
            children: [
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.sinisterDate))
                    ),
                 enabled: false,   
                 initialValue: siniestro.fechaSiniestro, 
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.sinisterNumber))
                    ),
                 enabled: false,   
                 initialValue: siniestro.numeroPoliza.toString(), 
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.sinisterImmission))
                    ),
                 enabled: false,   
                 initialValue: siniestro.indenmizacion, 
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.sinisterCouses))
                    ),
                 enabled: false,   
                 initialValue: siniestro.causas, 
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}