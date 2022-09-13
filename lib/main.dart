import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kullanicikayit/kayitekrani.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //-----------Firebase'i çalıştır-------------
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner:
        false, //sağ üstteki debug şeridini kaldırmak için
    home: const KayitUygulama(),
  ));
}

class KayitUygulama extends StatelessWidget {
  const KayitUygulama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KayitEkrani();
  }
}
