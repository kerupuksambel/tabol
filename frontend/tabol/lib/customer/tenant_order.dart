import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabol/model/service.dart';
import 'package:http/http.dart' as http;

Future<int> submitOrder(int tenantId, int id) async{
  final response = await http.get(Uri.parse('http://localhost:8000/api/tenant/submit/' + id.toString()));
  List<Service> result = [];
  print(response.body);
  if (response.statusCode == 200) {
    return jsonDecode(response.body)["id"];
  } else {
    throw Exception('Failed to load tenant');
  }
} 

class TenantOrder extends StatefulWidget {

  final Service service;
  const TenantOrder({Key? key, required this.service}) : super(key: key);  
  
  @override
	TenantOrderState createState() => TenantOrderState();
}

class TenantOrderState extends State<TenantOrder>{

  late Future<int> status;

  void initState(){
    super.initState();
    status = submitOrder(widget.service.tenantId, widget.service.id);
    Navigator.popAndPushNamed(context, '/tenant/detail/', arguments: widget.service.tenantId);
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
                            Navigator.pushNamed(context, '/tenant/submit', arguments: snapshot.data![idx].id);
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}