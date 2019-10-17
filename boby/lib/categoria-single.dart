import 'single-produto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

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
  int tamanho;
  bool _loadingInProgress;

  var connectivityResult;
  Future buscarConexao( ) async {
    connectivityResult = await Connectivity().checkConnectivity();
  }
  @override
  Future initState() {
    buscarConexao();
    _loadingInProgress = true;
    getProdutos(id).whenComplete(() {
      getAppDados();
      _loadData();
    });
  }

  _launchURL(String numero) async {
    var url = 'https://wa.me/${numero}?text=Olá, estou interessado em um produto que vi no aplicativo';
    if (await canLaunch(url)) {
      await launch(url, enableJavaScript: true, forceWebView: false);
    } else {
      throw 'Não foi possivel abrir $url';
    }
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 1));
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  Widget _buildBody() {
    if (connectivityResult == ConnectivityResult.mobile) {
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
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "${nome}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                ),
                Divider(),
                Container(
                  height: (MediaQuery.of(context).size.height) / 1.3,
                  child: Swiper(
                    itemHeight: (MediaQuery.of(context).size.height) / 1.3,
                    control: new SwiperControl(),
                    loop: true,
                    autoplay: true,
                    autoplayDisableOnInteraction: true,
                    autoplayDelay: 5000,
                    itemCount: produtos == null ? 0 : produtos.length,
                    itemBuilder: (BuildContext context, int index) {
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
                                "http://boby.con4.com.br/imagens/${produtos[index]["0"]["foto"]}",
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
                                "R\$${produtos[index]["preco"].replaceAll('.', ',')} em até ${produtos[index]["parcelas"]}x",
                                style:
                                TextStyle(fontSize: 25.0, color: Colors.blue),
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
                  "Mais produtos",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                ),
                Divider(),
                GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1),
                  ),
                  itemCount: produtos == null ? 0 : produtos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Produto(produtos[index]["id"])));
                      },
                      child: new Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.network(
                              "http://boby.con4.com.br/imagens/${produtos[index]["0"]["foto"]}",
                              fit: BoxFit.fill,
                              height: MediaQuery.of(context).size.height / 4.7,
                            ),
                            Divider(),
                            Text(
                              produtos[index]["nome"],
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              produtos[index]["descricao"],
                            ),
                            Text(
                              "R\$${produtos[index]["preco"].replaceAll('.', ',')} em até ${produtos[index]["parcelas"]}x",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
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
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "${nome}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                ),
                Divider(),
                Container(
                  height: (MediaQuery.of(context).size.height) / 1.3,
                  child: Swiper(
                    itemHeight: (MediaQuery.of(context).size.height) / 1.3,
                    control: new SwiperControl(),
                    loop: true,
                    autoplay: true,
                    autoplayDisableOnInteraction: true,
                    autoplayDelay: 5000,
                    itemCount: produtos == null ? 0 : produtos.length,
                    itemBuilder: (BuildContext context, int index) {
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
                                "http://boby.con4.com.br/imagens/${produtos[index]["0"]["foto"]}",
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
                                "R\$${produtos[index]["preco"].replaceAll('.', ',')} em até ${produtos[index]["parcelas"]}x",
                                style:
                                TextStyle(fontSize: 25.0, color: Colors.blue),
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
                  "Mais produtos",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                ),
                Divider(),
                GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1),
                  ),
                  itemCount: produtos == null ? 0 : produtos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Produto(produtos[index]["id"])));
                      },
                      child: new Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Image.network(
                              "http://boby.con4.com.br/imagens/${produtos[index]["0"]["foto"]}",
                              fit: BoxFit.fill,
                              height: MediaQuery.of(context).size.height / 4.7,
                            ),
                            Divider(),
                            Text(
                              produtos[index]["nome"],
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              produtos[index]["descricao"],
                            ),
                            Text(
                              "R\$${produtos[index]["preco"].replaceAll('.', ',')} em até ${produtos[index]["parcelas"]}x",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }
    } else {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Divider(
                height: 30.0,
              ),
              Text(
                "Carregando conteúdo...",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }
  }


  Future getProdutos(String idCategoria) async {
    http.Response request = await http.get(
        "http://boby.con4.com.br/api/api.php?selecionarTodosprodutosCategoriaApi&id_categoria=${idCategoria}");
    produtos = json.decode(request.body);
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
