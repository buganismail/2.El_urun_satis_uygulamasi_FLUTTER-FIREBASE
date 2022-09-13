import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanicikayit/anasayfa.dart';
import 'package:kullanicikayit/kayitekrani.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  //---------------Giriş Parametreleri------------
  String email = "", sifre = "";

  // Doğrulama Anahtarı
  var _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Ekranı"),
        centerTitle: true,
      ),
      body: Form(
        key: _formAnahtari,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // E-mail Giriş
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (alinanEmail) {
                    email = alinanEmail;
                  },
                  validator: (alinanEmail) {
                    return alinanEmail.toString().contains("@")
                        ? null
                        : "Geçersiz E-mail";
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // Şifre Giriş
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (alinanSifre) {
                    sifre = alinanSifre;
                  },
                  validator: (alinanSifre) {
                    return alinanSifre!.length >= 6 ? null : "En az 6 karakter";
                  },
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // Giriş Butonu
              Container(
                padding: EdgeInsets.all(8.0),
                height: 70,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    girisYap();
                  },
                  child: Text("Giriş"),
                ),
              ),
              // Hesabım Yok
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => KayitEkrani()));
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Hesabım Yok",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Email ve şifreye göre doğrulama yapacak
  void girisYap() {
    if (_formAnahtari.currentState!.validate()) {
      //giriş yap
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        //Eğer başarılıysa anasayfaya git
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => AnaSayfa()), (route) => false);
      }).catchError((hata) {
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
