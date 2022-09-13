import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kullanicikayit/anasayfa.dart';
import 'package:kullanicikayit/girisekrani.dart';

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({Key? key}) : super(key: key);

  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State {
  //---------kayıt parametreleri tutucuları-------
  String email = "", sifre = "";

  //----------
  var _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Kayıt"), //Kayıt Başlık
        centerTitle: true, //Kayıt Başlık Ortalama
      ),
      body: Form(
        key: _formAnahtari,
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //E-mail giriş
                TextFormField(
                  onChanged: (alinanMail) {
                    setState(() {
                      email = alinanMail;
                    });
                  },
                  validator: (alinanMail) {
                    return alinanMail.toString().contains("@")
                        ? null
                        : "Mail Geçersiz";
                  },
                  keyboardType:
                      TextInputType.emailAddress, //klavyeye @ işareti verme
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder(),
                  ),
                ),
                // TextBoxlar arası boşluk sağlama
                SizedBox(
                  height: 15,
                ),
                // Şifre giriş
                TextFormField(
                  onChanged: (alinanSifre) {
                    setState(() {
                      sifre = alinanSifre;
                    });
                  },
                  validator: (alinanSifre) {
                    return alinanSifre!.length >= 6 ? null : "En az 6 karakter";
                  },
                  obscureText: true, // Text'i gizleme
                  decoration: InputDecoration(
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                  ),
                ),
                // TextBoxlar arası boşluk sağlama
                SizedBox(
                  height: 15,
                ),
                // Kayıt Ol
                Container(
                  width: double.infinity, // Kayıt Ol butonu genişlik
                  height: 40, // Kayıt Ol butonu uzunluk
                  child: ElevatedButton(
                    onPressed: () {
                      kayitEkle();
                    },
                    child: Text("Kayıt Ol"),
                    style: ElevatedButton.styleFrom(
                      textStyle: GoogleFonts.roboto(fontSize: 24),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                // Hesabım Var
                Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      //----------Giriş Sayfasına gitsin
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => GirisEkrani()));
                    },
                    child: Text(
                      "Hesabım Var",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //-----------email ve şifreye göre firebase e kullanıcı ekle-------------
  void kayitEkle() {
    if (_formAnahtari.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        //-----------başarılıysa anasayfaya git
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => AnaSayfa()),
            (Route<dynamic> route) => false);
      }).catchError((hata) {
        //-----------başarılı değilse hata mesajı göster
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
