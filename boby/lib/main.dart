import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BOBY", style: TextStyle(color: Colors.white, fontSize: 25.0), textAlign: TextAlign.center,),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 600.0,
            padding: EdgeInsets.all(0),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Container(
                    color: Colors.amberAccent,
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          "Categoria",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23.0,
                          ),
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
