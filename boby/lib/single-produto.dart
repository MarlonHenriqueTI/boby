import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Produto extends StatefulWidget {
  @override
  _ProdutoState createState() => _ProdutoState();
}

class _ProdutoState extends State<Produto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 35.0,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "BOBY",
          style: TextStyle(color: Colors.black54, fontSize: 25.0),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesome.getIconData("whatsapp"),
              size: 35.0,
              color: Colors.black54,
            ),
            onPressed: _launchURL,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
                "https://www.pontofrio-imagens.com.br/ArVentilacao/Aquecedores/aquecedorEletrico/2233506/11665760/Aquecedor-Cadence-Halogenio-Oscilante-Comodita-1200W-com-3-niveis-de-aquecimento-AQC300-Preto-2233506.jpg"),
            Divider(),
            Text(
              "Nome Do Produto",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.amber,
              ),
              textAlign: TextAlign.center,
            ),
            Divider(),
            Text(
              "R\$500,00",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.orange,
              ),
              textAlign: TextAlign.justify,
            ),
            Divider(),
            Text(
              "Especificações",
              style: TextStyle(
                fontSize: 25.0,
              ),
              textAlign: TextAlign.justify,
            ),
            Divider(),
            Text(
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of ",
              textAlign: TextAlign.justify,
            ),
            Divider(),
            FlatButton(
                onPressed: _launchURL,
                color: Colors.green[700],
                padding: EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(),
                child: Text(
                  "Chamar No WhatsApp",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  textAlign: TextAlign.center,
                )),
            Divider(),
          ],
        ),
      ),
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
