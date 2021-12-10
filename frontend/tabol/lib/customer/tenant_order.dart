import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabol/model/service.dart';
import 'package:http/http.dart' as http;

Future<int> submitOrder(Service service) async{
  final response = await http.post(Uri.parse('http://localhost:8000/api/tenant/submit/'), 
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "service_id" : service.id,
      "tenant_id" : service.tenantId,
      "lat" : -8.073240,
      "long" : 111.907340
    })
  );
  print(response.statusCode);
  
  if (response.statusCode == 200) {
    var decoded = json.decode(response.body);
    print(decoded['success']);
    return decoded['success'];
    
  } else {
    print(response.body);
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
    submitOrder(widget.service).then((id) {
      Navigator.pushReplacementNamed(context, "/order/list/");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				title: Text("Service"),
			),
      body: Center(
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}