import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tabol/model/order.dart';
import 'package:http/http.dart' as http;

Future<int> finishOrder(Order order) async{
  final response = await http.post(
    Uri.parse('http://localhost:8000/api/order/'+ order.id.toString() +'/finish/'), 
    body: jsonEncode({"id" : order.id})
  );
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

Future<int> rateOrder(Order order, String rate) async{
  order.rating = int.parse(rate);
  final response = await http.post(
    Uri.parse('http://localhost:8000/api/order/' + order.id.toString() +'/rate/'), 
    body: jsonEncode({
      "id" : order.id,
      "rating" : order.rating
    })
  );
  print(response.statusCode);
  
  if (response.statusCode == 200) {
    var decoded = json.decode(response.body);
    print(decoded['success']);
    return decoded['success'];
    
  } else {
    throw Exception('Failed to load tenant');
  }
}

class OrderFinish extends StatefulWidget {

  final Order order;
  const OrderFinish({Key? key, required this.order}) : super(key: key);  
  
  @override
	OrderFinishState createState() => OrderFinishState();
}

class OrderFinishState extends State<OrderFinish>{

  late Future<int> status;

  void initState(){
    super.initState();
    finishOrder(widget.order).then((id) {
      if(id == 0){
        Navigator.pushReplacementNamed(context, "/order/list/");
      }
    });
  }

  final txtController = TextEditingController();

  @override
  void dispose(){
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				title: Text("Service"),
			),
      body: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Text("Rate"),
            TextField(
              controller: txtController,
            ),
            ElevatedButton(
              onPressed: ((){
                rateOrder(widget.order, txtController.text).then((res){
                  if(res == 1){
                    Navigator.pushReplacementNamed(context, '/order/list/');
                  }else{
                    
                  }
                });
              }), 
              child: Text("Submit")
            )
          ]
        )
      ),
    );
  }
}