import 'package:boby/single-produto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Categoria extends StatefulWidget {
  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
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
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "Nome Da Categoria",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, color: Colors.amber),
              ),
              Divider(),
              CarouselSlider(
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                pauseAutoPlayOnTouch: Duration(seconds: 10),
                height: 600.0,
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Produto()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(
                                  "https://www.pontofrio-imagens.com.br/ArVentilacao/Aquecedores/aquecedorEletrico/2233506/11665760/Aquecedor-Cadence-Halogenio-Oscilante-Comodita-1200W-com-3-niveis-de-aquecimento-AQC300-Preto-2233506.jpg"),
                              Divider(),
                              Text(
                                "nome",
                                style: TextStyle(fontSize: 25.0),
                              ),
                              Text(
                                "R\$500,00",
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.orange),
                              ),
                              Divider(),
                              Text(
                                  "Texto de uma linha explicando algumas coisas do produto"),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Text(
                "Produtos",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0, color: Colors.amber),
              ),
              Divider(),
              Container(
                height: (MediaQuery.of(context).size.height) / 1.3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Produto()));
                      },
                      child: new Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.amber, style: BorderStyle.solid),
                        ),
                        height: 500.0,
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
                                fontSize: 23.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
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
