import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabol/model/service.dart';
import 'package:http/http.dart' as http;

Future<List<Service>> fetchServices(int id) async{
  final response = await http.get(Uri.parse('http://localhost:8000/api/tenant/service/' + id.toString()));
  List<Service> result = [];
  print(response.body);
  if (response.statusCode == 200) {
    for (var item in jsonDecode(response.body)) {
      result.add(Service.fromJson(item));
    }
    return result;
  } else {
    throw Exception('Failed to load tenant');
  }
} 

class TenantService extends StatefulWidget {

  final int id;
  const TenantService({Key? key, required this.id}) : super(key: key);  

  @override
	TenantServiceState createState() => TenantServiceState();
}

class TenantServiceState extends State<TenantService>{

  late Future<List<Service>> futureServices;

  void initState(){
    super.initState();
    futureServices = fetchServices(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				title: Text("Service"),
			),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<List<Service>>(
              future: futureServices,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return  ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int idx){
                      // return Container(
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Row(
                      //       children: [
                      //         Text('${snapshot.data![idx].nama}'),
                      //         Text('${snapshot.data![idx].harga}'),
                      //       ]
                      //     ),
                      //   )
                      // );
                      return ListTile(
                        trailing: ElevatedButton(
                          child: Text('${snapshot.data![idx].hargaFormat}'),
                          onPressed: (){
                            Navigator.pushNamed(context, '/tenant/order/', arguments: snapshot.data![idx].id);
                          },
                        ),
                        title: Text('${snapshot.data![idx].nama}')
                      );
                    }, 
                    separatorBuilder: (BuildContext context, int index) => const Divider(), 
                    itemCount: snapshot.data!.length
                  );
                }

                return const CircularProgressIndicator();
              }, 
            )
          ]
        )
      ),
      floatingActionButton: FloatingActionButton(
				onPressed: (){
          Navigator.pushNamed(context, '/tenant/service/', arguments: widget.id);
        },
				tooltip: 'Pesan',
				child: Icon(Icons.shopping_cart),
			), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}