import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tabol/model/tenant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerHomePage extends StatefulWidget {
	CustomerHomePage({Key? key, required this.title}) : super(key: key);

	final String title;

	@override
	_CustomerHomePageState createState() => _CustomerHomePageState();
}

Future<List<Tenant>> fetchTenants() async{
  final response = await http.get(Uri.parse('http://localhost:8000/api/tenant'));
  List<Tenant> result = [];
  if (response.statusCode == 200) {
    for (var item in jsonDecode(response.body)) {
      result.add(Tenant.fromJson(item));
    }
    return result;
  } else {
    throw Exception('Failed to load tenants');
  }
} 

class _CustomerHomePageState extends State<CustomerHomePage> {

	late Future<List<Tenant>> futureTenants;

  void initState(){
    super.initState();
    futureTenants = fetchTenants();
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
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
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
                                      Text('${snapshot.data![idx].rating} / 5', textAlign: TextAlign.center,)
                                    ]
                                  )
                                )
                              ]
                            )
                          )
                        ),
                        onTap: () async {
                          // print('${snapshot.data![idx].id}');
                          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          print(sharedPreferences.getInt("id"));
                          Navigator.pushNamed(context, '/tenant/detail/', arguments: snapshot.data![idx].id);
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
