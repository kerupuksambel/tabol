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

  Tenant({
    required this.userId,
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.photoUrl
  });

  factory Tenant.fromJson(Map<String, dynamic> json) {
    return Tenant(
      userId: json['user_id'],
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      photoUrl: json['photo_url']
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
    // return Tenant.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
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
		// This method is rerun every time setState is called, for instance as done
		// by the _incrementCounter method above.
		//
		// The Flutter framework has been optimized to make rerunning build methods
		// fast, so that you can just rebuild anything that needs updating rather
		// than having to individually change instances of widgets.
		return Scaffold(
			appBar: AppBar(
				// Here we take the value from the MyHomePage object that was created by
				// the App.build method, and use it to set our appbar title.
				title: Text(widget.title),
			),
			body: Center(
				// Center is a layout widget. It takes a single child and positions it
				// in the middle of the parent.
				child: Column(
					// Column is also a layout widget. It takes a list of children and
					// arranges them vertically. By default, it sizes itself to fit its
					// children horizontally, and tries to be as tall as its parent.
					//
					// Invoke "debug painting" (press "p" in the console, choose the
					// "Toggle Debug Paint" action from the Flutter Inspector in Android
					// Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
					// to see the wireframe for each widget.
					//
					// Column has various properties to control how it sizes itself and
					// how it positions its children. Here we use mainAxisAlignment to
					// center the children vertically; the main axis here is the vertical
					// axis because Columns are vertical (the cross axis would be
					// horizontal).
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
                      return Container(
                        height: 200,
                        color: Colors.white,
                        child: Center(
                          child: Column(
                            children: [
                              Image.network('${snapshot.data![idx].photoUrl}'),
                              Text('${snapshot.data![idx].nama}'),
                            ]
                          )
                        )
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
            )
						// Text(
						// 	'$_counter',
						// 	style: Theme.of(context).textTheme.headline4,
						// ),
					],
				),
			),
			floatingActionButton: FloatingActionButton(
				onPressed: _incrementCounter,
				tooltip: 'Increment',
				child: Icon(Icons.add),
			), // This trailing comma makes auto-formatting nicer for build methods.
		);
	}
}
