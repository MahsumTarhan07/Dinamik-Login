import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  late String spKullaniAdi;
  late String spSifre;

  Future<void> oturumBilgisiOku() async{
    var sp = await SharedPreferences.getInstance();

    setState(() {
      spKullaniAdi = sp.getString("kullaniciAdi") ?? "Kullanici Adi Yok";
      spSifre = sp.getString("sifre") ?? "Sifre Yok";

    });
  }

  @override
  void initState() {
    super.initState();
    oturumBilgisiOku();
  }



  Future<void> cikisYap() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("kullaniciAdi");
    sp.remove("sifre");

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginEkran()));

  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnaSayfa"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
                cikisYap();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Kullanici Adi : $spKullaniAdi " , style: TextStyle(fontSize: 30),),
            Text("Kullanici Sifre : $spSifre " , style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }
}
