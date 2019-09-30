import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'dart:convert';

class Produto extends StatefulWidget {
  String id;

  Produto(this.id);

  @override
  _ProdutoState createState() => _ProdutoState(id);
}

class _ProdutoState extends State<Produto> {
  String id;

  _ProdutoState(this.id);

  List produtos;
  List dados;
  List fotos;
  bool _loadingInProgress;

  _launchURL(String numero) async {
    var url = 'https://wa.me/${numero}?text=Ola vim pelo app';
    if (await canLaunch(url)) {
      await launch(url, enableJavaScript: true, forceWebView: false);
    } else {
      throw 'Não foi possivel abrir $url';
    }
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 3));
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  Widget _buildBody() {
    if (_loadingInProgress) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 35.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "ROCHA",
            style: TextStyle(color: Colors.white, fontSize: 25.0),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  FontAwesome.getIconData("whatsapp"),
                  size: 35.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  _launchURL(dados[0]["whatsapp"]);
                }),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height) / 1.5,
                width: (MediaQuery.of(context).size.width),
                child: Swiper(
                  pagination: new SwiperPagination(),
                  loop: true,
                  autoplay: true,
                  autoplayDisableOnInteraction: true,
                  autoplayDelay: 5000,
                  itemCount: fotos == null ? 0 : fotos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: (MediaQuery.of(context).size.width),
                      height: 500.0,
                      padding: EdgeInsets.all(10.0),
                      child: Image.network(
                        "http://boby.con4.com.br/imagens/${fotos[index]["foto"]}",
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Text(
                produtos[0]["nome"],
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(),
              Text(
                "R\$${produtos[0]["preco"]} em até ${produtos[0]["parcelas"]}x",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.justify,
              ),
              Divider(),
              Text(
                "Especificações:",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              Divider(),
              Text(
                produtos[0]["especifica"],
                textAlign: TextAlign.justify,
              ),
              Divider(),
              Text(
                "Contato:",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.justify,
              ),
              Divider(),
              Text(
                "Email: ${produtos[0]["email"]}",
              ),
              Text(
                produtos[0]["telefone"] == "" ? "Telefone: ${produtos[0]["telefone"]}" : "",
              ),
              Divider(),
              FlatButton(
                  onPressed: () {
                    _launchURL(produtos[0]["wpp"]);
                  },
                  color: Colors.blue[700],
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

  void getProdutos(String id) async {
    http.Response request = await http.get(
        "http://boby.con4.com.br/api/api.php?selecionarprodutoApi&id=${id}");
    produtos = json.decode(request.body);
  }

  void getFotos(String id) async {
    http.Response request = await http.get(
        "http://boby.con4.com.br/api/api.php?selecionarTodasfotosProdutoApi&id_produto=${id}");
    fotos = json.decode(request.body);
  }

  void getAppDados() async {
    http.Response request =
        await http.get("http://boby.con4.com.br/api/api.php?selecionarAppApi");
    dados = json.decode(request.body);
  }

  @override
  Future initState() {
    _loadingInProgress = true;
    getProdutos(id);
    getAppDados();
    getFotos(id);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
