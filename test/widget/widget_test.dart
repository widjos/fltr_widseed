// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:test/pages/clients/page_clients.dart';
import 'package:test/pages/insurance/page_insurance.dart';

import 'package:test/pages/page_one/page_one.dart';

import 'package:test/pages/page_settings/page_settings.dart';
import 'package:test/pages/page_two/page_two.dart';
import 'package:test/pages/sinister/page_sinister.dart';

import 'package:test/prefs/theme_provider.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/widgets/button_green.dart';
import 'package:test/widgets/button_icon.dart';

import '../settings/init_config.dart';


void main() {
  
  ThemeProvider themeProvider = ThemeProvider(); 
  LanguageProvider langProvider = LanguageProvider();
  langProvider.setLaguaje = Locale('es','ES');

  testWidgets('Settings y buscar si existe el texto de Configuraciones', (WidgetTester tester) async {
 
    // Build our app and trigger a frame.
    await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child: const MaterialApp(
          locale: Locale('es','ES'),
          home:  PageSettings()
          ),  
        )
      );
      await tester.pump();

    
      expect(find.text('Configuraciones'), findsOneWidget);
      expect(find.text('Settings'), findsNothing);
   
     

    // Verify that our counter starts at 0.
    // 
    //expect(find.text('Nada'), findsNothing);

    // Tap the 'settings' icon and trigger a next view.
    //await tester.tap(find.byIcon(Icons.settings));
    //await tester.pumpWidget(const PageSettings());
    
    
    /*//Tap the switch for the theme color
    await tester.tap(find.byType(DropdownButton));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    final dropdownItem = find.text('English').last;
    
    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    */
    
  });

  testWidgets('Verificar titulo pagina principal',(WidgetTester tester) async {

      await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child:  MaterialApp(
        locale: const Locale('es','ES'),
        home:  PageOne(theme: false)
      ),  
      )
      );
      await tester.pump();
      
      //Verificar si se encuentra bienvenido
      //expect(find.text('Bienvenido'), findsOneWidget);

  });
  testWidgets('Ingresar al Settings desde  la pagina principal',(WidgetTester tester) async {

      await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child:    MaterialApp(
          locale: const Locale('es','ES'),
          home:  PageOne(theme: false)
          ),  
        )
      );
      await tester.pump();
      
     expect(find.text('Welcome'), findsNothing);

  });


  testWidgets('Open Page two and check the  menu  text exist',(WidgetTester tester) async {

      await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child:    MaterialApp(
          locale: const Locale('es','ES'),
          home:  PageTwo(tittle: 'titulo', theme: false)
          ),  
        )
      );
      await tester.pump();
      
     expect(find.text('Clientes'), findsOneWidget);
     expect(find.text('Seguros'), findsOneWidget);


  });
  testWidgets('Open settings page from Home Page ',(WidgetTester tester) async {

      await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child:    MaterialApp(
          locale: const Locale('es','ES'),
          home:  PageTwo(tittle: 'titulo', theme: false)
          ),  
        )
      );
      await tester.pump();


     await tester.tap(find.byIcon(Icons.settings));

     //Open the settings page
     await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child: const MaterialApp(
          locale: Locale('es','ES'),
          home:  PageSettings()
          ),  
        )
      );
      await tester.pump();

     expect(find.byType(Container), findsWidgets); 
     expect(find.byIcon(Icons.abc_outlined), findsWidgets);   //Tap the switch for the theme color



  });
  testWidgets('Check text Insets',(WidgetTester tester) async {

      await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child:    MaterialApp(
          locale: const Locale('es','ES'),
          home:  PageOne(theme: false)
          ),  
        )
      );
    
    // Check if the correo text exist
     tester.any(find.text('Correo'));
    // 
    tester.any(find.byType(ButtonGreen));
  });

  
  testWidgets('Open Settings and check Title in spanish', (WidgetTester tester) async {
 
    // Build our app and trigger a frame.
    await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child: const MaterialApp(
          locale: Locale('es','ES'),
          home:  PageSettings()
          ),  
        )
      );
      await tester.pump();

    
      expect(find.text('Configuraciones'), findsOneWidget);
      tester.any(find.byType(ButtonIcon));
     

    
  });


  testWidgets('Clientes show page', (WidgetTester tester) async {
 
    // Build our app and trigger a frame.
    await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child:  MaterialApp(
          locale: const Locale('es','ES'),
          home:  PageClients(theme: false)
          ),  
        )
      );
      await tester.pump();

    
      expect(find.text('Clientes'), findsOneWidget);
    
     

    
  });
  testWidgets('Siniestros show page', (WidgetTester tester) async {
 
    // Build our app and trigger a frame.
    await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child:  MaterialApp(
          locale: const Locale('es','ES'),
          home:  PageSinister()
          ),  
        )
      );
      await tester.pump();

    
      expect(find.text('Siniestros'), findsOneWidget);

  });

  testWidgets('Seguros show page', (WidgetTester tester) async {
 
    // Build our app and trigger a frame.
    await tester.pumpWidget( ChangeNotifierProvider.value(
      value: langProvider,
      child:  MaterialApp(
          locale: const Locale('es','ES'),
          home:  PageInsurance(theme: false,)
          ),  
        )
      );
      await tester.pump();

    
      expect(find.text('Seguros'), findsOneWidget);

  });


}

