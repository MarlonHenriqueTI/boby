import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

class Sobre extends StatefulWidget {
  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  bool _loadingInProgress;
  var connectivityResult;
  List dados;

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 3));
    _dataLoaded();
  }

  void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }

  Future buscarConexao() async {
    connectivityResult = await Connectivity().checkConnectivity();
  }

  _launchURL(String numero) async {
    var url =
        'https://wa.me/${numero}?text=Olá, estou interessado em um produto que vi no aplicativo.';
    if (await canLaunch(url)) {
      await launch(url, enableJavaScript: true, forceWebView: false);
    } else {
      throw 'Não foi possivel abrir $url';
    }
  }

  @override
  Future initState() {
    buscarConexao();
    _loadingInProgress = true;
    getAppDados().whenComplete(() {
      _loadData();
    });
  }

  Future getAppDados() async {
    http.Response request =
        await http.get("http://boby.con4.com.br/api/api.php?selecionarAppApi");
    dados = json.decode(request.body);
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
                  }),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Sobre a Empresa",
                  style: TextStyle(fontSize: 28.0, color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
                Divider(),
                Text(
                  dados[0]["sobre"],
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 19.0),
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
                  }),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Sobre a Empresa",
                  style: TextStyle(fontSize: 28.0, color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
                Divider(),
                Text(
                  dados[0]["sobre"],
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 19.0),
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

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
