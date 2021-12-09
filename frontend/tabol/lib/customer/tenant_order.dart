import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabol/model/service.dart';
import 'package:http/http.dart' as http;

Future<int> submitOrder(int tenantId, int id) async{
  final response = await http.post(Uri.parse('http://localhost:8000/api/tenant/submit/'));
  print(response.statusCode);
  
  if (response.statusCode == 200) {
    var decoded = json.decode(response.body);
    print(decoded['success']);
    return decoded['success'];
    
  } else {
    print("error");
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
    submitOrder(widget.service.tenantId, widget.service.id).then((id) {
      Navigator.pushReplacementNamed(context, "/tenant/detail/", arguments: 1);
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