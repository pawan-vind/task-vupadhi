import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashUtils {
  static String generateSalt() {
    final rand = Random();
    return rand.nextInt(1000000).toString().padLeft(6, '0'); 
  }

  static String generateMD5(String input) {
    final bytes = utf8.encode(input); 
    final digest = md5.convert(bytes);
    return digest.toString(); 
  }

  static String generateFinalPassword(String password, String salt) {
    final hashedPassword = generateMD5(password);
    final combined = generateMD5(hashedPassword + salt);
    return combined;
  }
}
