import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'categoria-single.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DrawerWidget extends StatefulWidget {
  List dados;
  List categoria;
  DrawerWidget(this.dados, this.categoria);
  @override
  _DrawerWidgetState createState() => new _DrawerWidgetState(dados, categoria);
}

class _DrawerWidgetState extends State<DrawerWidget> {

  List categoria;
  List dados;
  _DrawerWidgetState(this.dados, this.categoria);
  @override

  int pagina;
//Cria uma listview com os itens do menu
  Widget _listMenu() {
    return ListView(
      children: <Widget>[
        Divider(),
        _tiles("CHAMAR NO WHATSAPP", FontAwesome.getIconData("whatsapp"), 1, (){
          _launchURL("https://wa.me/${dados[0]["whatsapp"]}?text=Ola vim pelo app");
        }),
        Divider(),
        _tiles("TELEFONE: ${dados[0]["telefone"]}", Icons.call, 1,(){}),
        Divider(),
        _tiles("E_MAIL: ${dados[0]["email"]}", Icons.mail_outline, 1, (){
          _launchURL("mailto:${dados[0]["email"]}");
        }),
        Divider(),

      ],
    );
  }

//cria cada item do menu
  Widget _tiles(String text, IconData icon, int item, Function onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.amber,),
      onTap: onTap,
      selected: item == pagina,
      title: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black54,
          child: _listMenu()),
    );
  }
}



_launchURL(String link) async {
  var url = link;
  if (await canLaunch(url)) {
    await launch(url, enableJavaScript: true, forceWebView: false);
  } else {
    throw 'Não foi possivel abrir $url';
  }
}