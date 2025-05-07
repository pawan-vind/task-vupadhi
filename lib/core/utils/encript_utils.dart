import 'dart:convert';
import 'package:encrypt/encrypt.dart';

class EncryptionUtils {
  static final _key = Key.fromUtf8('my32lengthsupersecretnooneknows1');

  static String encrypt(String plainText) {
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    final combined = iv.bytes + encrypted.bytes;
    return base64Encode(combined);
  }

  static String decrypt(String encryptedText) {
    final combined = base64Decode(encryptedText);
    final iv = IV(combined.sublist(0, 16));
    final ciphertext = combined.sublist(16);

    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    final encrypted = Encrypted(ciphertext);
    return encrypter.decrypt(encrypted, iv: iv);
  }
}
