import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabol/model/order.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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

Future<int> rateOrder(int id, double rating) async{
  final response = await http.post(
    Uri.parse('http://localhost:8000/api/order/' + id.toString() +'/rate/'), 
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "id" : id,
      "rating" : rating
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
  late double _rating;

  void initState(){
    super.initState();
    finishOrder(widget.order).then((id) {
      if(id == 0){
        Navigator.pushReplacementNamed(context, "/order/list/");
      }
    });
    _rating = 0.0;
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
      // appBar: AppBar(
			// 	title: Text("Service"),
      //   automaticallyImplyLeading: false,
			// ),
      body: Center(
        // alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Terimakasih sudah memesan!", style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.blue,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
              )
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (_rating == 0.0) ? null : ((){
                    rateOrder(widget.order.id, _rating).then((res){
                      if(res == 1){
                        Navigator.pushReplacementNamed(context, '/order/list/');
                      }
                    });
                  }), 
                  child: Text("Submit"),
                ),
                Padding(padding: (widget.order.rating != null) ? EdgeInsets.fromLTRB(8, 0, 8, 0) : EdgeInsets.all(0)),
                (widget.order.rating != null) ?
                TextButton(
                  onPressed: ((){
                    Navigator.pop(context);
                  }), 
                  child: Text("Kembali"),
                ) : Text("")
              ],
            )
          ]
        )
      ),
    );
  }
}