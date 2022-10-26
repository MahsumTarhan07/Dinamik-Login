import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sp_login/Anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Future<bool> oturumBilgisiOku() async{
    var sp = await SharedPreferences.getInstance();

     String spKullaniAdi = sp.getString("kullaniciAdi") ?? "Kullanici Adi Yok";
     String spSifre = sp.getString("sifre") ?? "Sifre Yok";

     if(spKullaniAdi =="admin" && spSifre =="123"){
       return true;
     }else{
      return false;
     }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: oturumBilgisiOku(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            bool? gecisIzni = snapshot.data;
            if(gecisIzni == true){
              AnaSayfa();
            }else{
              LoginEkran();
            }
          }else{
            return Container();
          }
        },
      ),
    );
  }
}

class LoginEkran extends StatefulWidget {

  @override
  State<LoginEkran> createState() => _LoginEkranState();
}

class _LoginEkranState extends State<LoginEkran> {

  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> girisKontrol() async{
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;

    if(ka=="admin" && s =="123"){
      var sp = await SharedPreferences.getInstance();

      sp.setString("kullaniciAdi", ka);
      sp.setString("sifre", s);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AnaSayfa()));

    }else{
      scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text("Giriş Hatalı"),
      ));
    }

  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: tfKullaniciAdi,
                    decoration: InputDecoration(
                      hintText: "Kullanici Adi",
                    ),
                  ),
                  TextField(
                    controller: tfSifre,
                    decoration: InputDecoration(
                        hintText: "Kullanici Sifre"
                    ),
                  ),
                  RaisedButton(
                    child: Text("Giris Yap"),
                    onPressed: (){
                      girisKontrol();
                    },
                  )
                ],
              ),
            ),
      ),
    );
  }
}
