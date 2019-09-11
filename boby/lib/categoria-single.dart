import 'package:boby/single-produto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'dart:convert';

class Categoria extends StatefulWidget {
  String id;
  String nome;

  Categoria(this.id, this.nome);

  @override
  _CategoriaState createState() => _CategoriaState(id, nome);
}

class _CategoriaState extends State<Categoria> {
  String id;
  String nome;

  _CategoriaState(this.id, this.nome);

  List produtos;
  List dados;
  List fotos;
  int tamanho;
  bool _loadingInProgress;

  @override
  Future initState() {
    _loadingInProgress = true;
    getProdutos(id);
    getAppDados();
    _loadData();
  }

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
              onPressed: () {
                _launchURL(dados[0]["whatsapp"]);
              },
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
                  "${nome}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.amber),
                ),
                Divider(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.amber, style: BorderStyle.solid),
                  ),
                  height: (MediaQuery.of(context).size.height) / 1.3,
                  child: Swiper(
                    control: new SwiperControl(),
                    loop: true,
                    autoplay: true,
                    autoplayDisableOnInteraction: true,
                    autoplayDelay: 5000,
                    itemCount: produtos == null ? 0 : 3,
                    itemBuilder: (BuildContext context, int index) {
                      getFotos(produtos[index]["id"]);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Produto(produtos[index]["id"])));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Image.network(
                                "http://boby.con4.com.br/imagens/${fotos[0]["foto"]}",
                                fit: BoxFit.contain,
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Divider(),
                              Text(
                                produtos[index]["nome"],
                                style: TextStyle(fontSize: 25.0),
                              ),
                              Text(
                                "R\$${produtos[index]["preco"]}",
                                style: TextStyle(
                                    fontSize: 25.0, color: Colors.orange),
                              ),
                              Divider(),
                              Text(
                                produtos[index]["descricao"],
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "Produtos",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.amber),
                ),
                Divider(),
                Container(
                  height: (MediaQuery.of(context).size.height) / 1.3,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height/1.1),
                    ),
                    itemCount: produtos == null ? 0 : produtos.length,
                    itemBuilder: (BuildContext context, int index) {
                      getFotos(produtos[index]["id"]);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Produto(produtos[index]["id"])));
                        },
                        child: new Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.amber, style: BorderStyle.solid),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Image.network(
                                "http://boby.con4.com.br/imagens/${fotos[0]["foto"]}",
                                fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height/4.7,
                              ),
                              Divider(),
                              Text(
                                produtos[index]["nome"],
                                style: TextStyle(
                                  fontSize: 23.0,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                produtos[index]["descricao"],
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

  void getProdutos(String idCategoria) async {
    http.Response request = await http.get(
        "http://boby.con4.com.br/api/api.php?selecionarTodosprodutosCategoriaApi&id_categoria=${idCategoria}");
    produtos = json.decode(request.body);
    tamanho = produtos.length + 1;
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
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
