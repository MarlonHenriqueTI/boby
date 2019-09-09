import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'categoria-single.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BOBY',
      theme: ThemeData(
        primarySwatch: Colors.amber,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget(),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 35.0,
              color: Colors.black54,
            ),
            onPressed: () {
              _scaffoldKey.currentState.openDrawer();
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
          height: 600.0,
          color: Colors.amber[300],
          padding: EdgeInsets.all(0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Categoria()));
                },
                child: new Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.black12,
                              style: BorderStyle.solid))),
                  height: 100.0,
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(Icons.accessibility),
                          Text(
                            "Categoria de aquecedores",
                            style: TextStyle(
                              fontSize: 23.0,
                            ),
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

_launchURL() async {
  const url = 'https://wa.me/5531995012807?text=Ola vim pelo app';
  if (await canLaunch(url)) {
    await launch(url,enableJavaScript: true, forceWebView: false);
  } else {
    throw 'Não foi possivel abrir $url';
  }
}
