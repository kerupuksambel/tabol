import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
  
  @override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Tabol',
			theme: ThemeData(
				primarySwatch: Colors.red
			),
			home: MyHomePage(title: 'TABOL'),
      routes: <String, WidgetBuilder>{
        
      }
		);
	}
}

class MyHomePage extends StatefulWidget {
	MyHomePage({Key? key, required this.title}) : super(key: key);

	// This widget is the home page of your application. It is stateful, meaning
	// that it has a State object (defined below) that contains fields that affect
	// how it looks.

	// This class is the configuration for the state. It holds the values (in this
	// case the title) provided by the parent (in this case the App widget) and
	// used by the build method of the State. Fields in a Widget subclass are
	// always marked "final".

	final String title;

	@override
	_MyHomePageState createState() => _MyHomePageState();
}

class Tenant {
  final int userId;
  final int id;
  final String nama;
  final String deskripsi;
  final String photoUrl;
  final double rating;

  Tenant({
    required this.userId,
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.photoUrl,
    required this.rating
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      userId: json['user_id'],
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      photoUrl: json['photo_url'],
      rating: json['rating'],
    );
  }
}

Future<List<Tenant>> fetchTenant() async{
  final response = await http.get(Uri.parse('http://localhost:8000/api/tenant'));
  List<Tenant> result = [];
  if (response.statusCode == 200) {
    for (var item in jsonDecode(response.body)) {
      result.add(Tenant.fromJson(item));
    }
    return result;
  } else {
    throw Exception('Failed to load rating');
  }
} 

class _MyHomePageState extends State<MyHomePage> {
	int _counter = 0;

	List<String> entries = <String>["Test_1", "Test_2", "Test_3"];
	late Future<List<Tenant>> futureTenants;

  void initState(){
    super.initState();
    futureTenants = fetchTenant();
  }

	void _incrementCounter() {
		setState(() {
			_counter++;
		});
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(widget.title),
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					children: <Widget>[
						// Text(
						// 	'You have pushed the button this many times:',
						// ),
						// ListView.separated(
						// 	padding: const EdgeInsets.all(8),
						// 	shrinkWrap: true,
						// 	itemCount: entries.length,
						// 	itemBuilder: (BuildContext context, int idx){
						// 		return Container(
						// 			height: 50,
						// 			color: Colors.amber[200],
						// 			child: Center(child: Text('Entry ${entries[idx]}')),
									
						// 		);
						// 	},
						// 	separatorBuilder: (BuildContext context, int index) => const Divider(),
						// ),
            FutureBuilder<List<Tenant>>(
              future: futureTenants,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.separated(
                    padding: const EdgeInsets.all(8),
      							shrinkWrap: true,
                    itemBuilder: (BuildContext context, int idx){
                      return InkWell(
                        child: Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width * 0.2,
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                                      child: Image.network('${snapshot.data![idx].photoUrl}'),
                                    ),
                                    // Image.network('${snapshot.data![idx].photoUrl}'),
                                  ],
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('${snapshot.data![idx].nama}', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                                        child: Text('${snapshot.data![idx].deskripsi}', textAlign: TextAlign.left)
                                      ),
                                      Text('${snapshot.data![idx].rating}', textAlign: TextAlign.center,)
                                    ]
                                  )
                                )
                              ]
                            )
                          )
                        ),
                        onTap: (){
                          print('${snapshot.data![idx].id}');
                        },
                      ); 
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(), 
                    itemCount: snapshot.data!.length
                  );
                }else if(snapshot.hasError){
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              }
            ),
            // Container(
            //   child: Row(
            //     children: <Widget>[
            //       Flexible(
            //         child: new Text("A looooooooooooooooooong text", style: TextStyle(fontSize: 48),)
            //       )
            //     ],
            //   )
            // ),
						// Text(
						// 	'$_counter',
						// 	style: Theme.of(context).textTheme.headline4,
						// ),
					],
				),
			),
			// floatingActionButton: FloatingActionButton(
			// 	onPressed: _incrementCounter,
			// 	tooltip: 'Increment',
			// 	child: Icon(Icons.add),
			// ), // This trailing comma makes auto-formatting nicer for build methods.
		);
	}
}
