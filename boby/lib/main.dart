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
        title: Text(
          "BOBY",
          style: TextStyle(color: Colors.black54, fontSize: 25.0),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 600.0,
          color: Colors.amber,
          padding: EdgeInsets.all(0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    print("Container clicked");
                  },
                  child: new Container(
                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, style: BorderStyle.solid))),
                    height: 70.0,
                    padding: EdgeInsets.all(10.0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Categoria",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 23.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Icon(Icons.accessibility),
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
