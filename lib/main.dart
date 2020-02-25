import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main()=> runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HTTP Fetch Data",
      theme: new ThemeData(
          primarySwatch: Colors.deepOrange,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = "https://swapi.co/api/people/";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String>getJsonData() async{
    var response = await http.get(
      // Encode the URL
      Uri.encodeFull(url),
      // Only Accept JSON Response
      headers: {"Accept": "application/json"}
    );
    print(response.body);

    setState(() {
      var convertDatatoJson = json.decode(response.body);
      data = convertDatatoJson['results'];
    });

    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("HTTP Fetch Data"),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child: new Padding(padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Text("Name : " + data[index]['name'],
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),

                  new Padding(padding: const EdgeInsets.only(top: 2),),

                  new Text("Height : " + data[index]['height'],
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),

                  new Padding(padding: const EdgeInsets.only(top: 2),),

                  new Text("Weight : " + data[index]['mass'],
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),

                  new Padding(padding: const EdgeInsets.only(top: 2),),

                  new Text("Gender : " + data[index]['gender'],
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
