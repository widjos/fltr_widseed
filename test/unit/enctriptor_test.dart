import 'package:flutter_test/flutter_test.dart';
import 'package:test/util/encriptor.dart';

void main()  {    

  

  group('Try to encode password', ()  {
  
    test('Return done if the description is the same String passed', () async {
    const password = 'contraseña123';  
    final encripted = await Encriptor.shared.encriptar(password);
    String passDecode =  await Encriptor.shared.desencriptar( encripted.toString());
      
      expect(passDecode, password);
    
    });

  });

}