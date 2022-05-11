import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/model/insurance/insurance_list.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/util/app_strings.dart';

class ShowInsurance extends StatelessWidget {
  
  Insurance seguro;

  ShowInsurance({ Key? key, required this.seguro }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    AppLocalizations localization = AppLocalizations(lang.getLang);
    
    return AlertDialog(
      title:  Text(localization.dictionary(LabelsText.information)),
      content: Form(
        child: Container(
          height: 400,
          width: 400,
          child: ListView(
            children: [
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.seguroDateInit))
                    ),
                 enabled: false,   
                 initialValue: seguro.fechaInicio, 
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.seguroDateFinish))
                    ),
                 enabled: false,   
                 initialValue: seguro.fechaVencimiento, 
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.seguroRamo))
                    ),
                 enabled: false,   
                 initialValue: seguro.ramo, 
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.seguroClientDni))
                    ),
                 enabled: false,   
                 initialValue: seguro.dniCl.toString(), 
              ),
          ]),
        ),
      ),
      
    );
  }
}