import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'categoria-single.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'dart:convert';
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ROCHA',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  List categoria;
  List dados;

  bool _loadingInProgress;

  @override
  Future initState() {
    _loadingInProgress = true;
    getCategorias();
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
        key: _scaffoldKey,
        drawer: DrawerWidget(dados, categoria),
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                size: 35.0,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
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
          child: Container(
            color: Colors.grey[200],
            height: 600.0,
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: categoria == null ? 0 : categoria.length,
              itemBuilder: (BuildContext context, int index) {
                String id = categoria[index]["id"];
                String nome = categoria[index]["nome"];
                String icone = categoria[index]["icone"];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Categoria(id, nome)));
                  },
                  child: new Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black12, style: BorderStyle.solid),
                          top: BorderSide(
                              color: Colors.black12, style: BorderStyle.solid),
                          left: BorderSide(
                              color: Colors.black12, style: BorderStyle.solid),
                          right: BorderSide(
                              color: Colors.black12, style: BorderStyle.solid)),
                      color: Colors.white,
                    ),
                    height: 70.0,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Image.network(
                                "http://boby.con4.com.br/imagens/${icone}",
                                height: 30.0),
                            Text(
                              nome,
                              style: TextStyle(
                                fontSize: 23.0,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }
  }

  void getCategorias() async {
    http.Response request = await http.get(
        "http://boby.con4.com.br/api/api.php?selecionarTodasCategoriasApi");
    categoria = json.decode(request.body);
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
