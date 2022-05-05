import 'dart:convert';

import 'package:encrypt/encrypt.dart' as myEncript;

class Encriptor {
  final key = myEncript.Key.fromUtf8('my 32 length key................');
  final iv = myEncript.IV.fromLength(16);

  Encriptor._privateConstructor();

  static final Encriptor shared = Encriptor._privateConstructor();


  Future<String> encriptar(String  pass) async{
    final encrypter = myEncript.Encrypter(myEncript.AES(key, padding: null));
    return encrypter.encrypt(pass, iv: iv).base64;
  }

  Future<String> desencriptar(String passB64) async {
    final encrypter = myEncript.Encrypter(myEncript.AES(key, padding: null));
    final bytesPass =   (encrypter.decryptBytes(myEncript.Encrypted.fromBase64(passB64) ,iv: iv));
    final valueStr = utf8.decode(bytesPass);
    return valueStr;
  }

}