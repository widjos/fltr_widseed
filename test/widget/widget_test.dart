// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:test/pages/page_one/page_one.dart';

import 'package:test/pages/page_settings/page_settings.dart';

import 'package:test/prefs/theme_provider.dart';
import 'package:test/provider/language_provider.dart';
import 'package:test/widgets/button_icon.dart';

import '../settings/init_config.dart';


void main() {
  
  ThemeProvider themeProvider = ThemeProvider(); 
  LanguageProvider langProvider = LanguageProvider();
  langProvider.setLaguaje = Locale('es','ES');

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
      
     // expect(find.text('Welcome'), findsNothing);
     // expect(find.text('Bienvenido'), findsOneWidget);
    // Tap the 'settings' icon and trigger a next view.
    //await tester.tap(find.byIcon(Icons.settings));
    //await tester.pumpWidget(const PageSettings());

  });

  





}
