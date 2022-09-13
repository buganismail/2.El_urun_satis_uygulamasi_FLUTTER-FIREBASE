import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kullanicikayit/girisekrani.dart';

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnaSayfa"),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((user) {
                // Çıkış yaptıktan sonra giriş sayfasına git

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GirisEkrani(),
                    ),
                    (route) => false);
              });
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
    );
  }
}
