import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'categoria-single.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget();
  @override
  _DrawerWidgetState createState() => new _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  _DrawerWidgetState();
  int pagina;
//Cria uma listview com os itens do menu
  Widget _listMenu() {
    return ListView(
      children: <Widget>[
        Divider(),
        _tiles("CHAMAR NO WHATSAPP", FontAwesome.getIconData("whatsapp"), 1, (){}),
        Divider(),
        _tiles("TELEFONE: (XX)XXXX-XXXX", Icons.call, 1,(){}),
        Divider(),
        _tiles("E_MAIL: email@email.com", Icons.mail_outline, 1, (){}),
        Divider(),
        _tiles("CATEGORIA DE AQUECEDORES", Icons.person, 1, () {

        }),
        _tiles("CATEGORIA DE AQUECEDORES", Icons.account_balance, 1, () {

        }),
        _tiles("CATEGORIA DE AQUECEDORES", Icons.graphic_eq, 1, () {

        }),
        _tiles("CATEGORIA DE AQUECEDORES", Icons.assignment, 1, () {

        }),
        _tiles("CATEGORIA DE AQUECEDORES", Icons.attach_file, 2, () {

        }),
        _tiles("CATEGORIA DE AQUECEDORES", Icons.file_download, 3, () {

        }),
        _tiles("CATEGORIA DE AQUECEDORES", Icons.video_library, 4, () {

        }),

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



_launchURL() async {
  const url = 'https://wa.me/5531995012807?text=Ola vim pelo app';
  if (await canLaunch(url)) {
    await launch(url, enableJavaScript: true, forceWebView: false);
  } else {
    throw 'Não foi possivel abrir $url';
  }
}