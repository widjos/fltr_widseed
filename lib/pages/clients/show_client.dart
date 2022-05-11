import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/model/client/client_list.dart';
import 'package:test/prefs/localization.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/util/app_strings.dart';

class ShowClient extends StatelessWidget {

  Client cliente;

  ShowClient({ Key? key , required this.cliente }) : super(key: key);



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
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientLastName1))
                    ),
                 enabled: false,   
                 initialValue: cliente.apellido1, 
              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientLastName2))
                    ),
                 enabled: false,   
                 initialValue: cliente.apellido2, 

              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientCity))
                    ),
                 enabled: false,   
                 initialValue: cliente.ciudad, 

              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientClassVia))
                    ),
                 enabled: false,   
                 initialValue: cliente.claseVia, 

              ),
              TextFormField(
                decoration:  InputDecoration(
                    border: const UnderlineInputBorder(), label: Text(localization.dictionary(LabelsText.clientNameVia))
                    ),
                 enabled: false,   
                 initialValue: cliente.nombreVia, 

              ),
            ],
          ),
        ),
      ),
      
    );
  }
}