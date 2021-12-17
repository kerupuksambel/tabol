import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabol/model/order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<Order>> fetchOrders() async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  int? id = sharedPreferences.getInt("id");
  final response = await http.get(Uri.parse('http://localhost:8000/api/order/' + id.toString()));
  List<Order> result = [];
  print(response.body);
  if (response.statusCode == 200) {
    for (var item in jsonDecode(response.body)) {
      result.add(Order.fromJson(item));
    }
    return result;
  } else {
    throw Exception('Failed to load tenant');
  }
} 

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);  

  @override
	OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList>{

  late Future<List<Order>> futureOrders;

  void initState(){
    super.initState();
    futureOrders = fetchOrders();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				title: Text("Order"),
			),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<List<Order>>(
              future: futureOrders,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Expanded(child: 
                    ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (BuildContext context, int idx){
                        return ListTile(
                          trailing: ElevatedButton(
                            child: Text('Lihat'),
                            onPressed: (){
                              Navigator.pushNamed(context, '/order/detail/', arguments: snapshot.data![idx]);
                            },
                          ),
                          title: Text('${snapshot.data![idx].tenantName}'),
                          subtitle: Text('${snapshot.data![idx].createdAt}'),
                          leading: Icon(((){
                            switch (snapshot.data![idx].status) {
                              case "dipesan":
                                return Icons.access_time_filled;
                              case "diterima":
                                return Icons.airport_shuttle;
                              default:
                                return Icons.check;
                            }
                          })()) 
                            
                        );
                      }, 
                      separatorBuilder: (BuildContext context, int index) => const Divider(), 
                      itemCount: snapshot.data!.length
                    )
                  );
                }else{
                  print(snapshot.error);
                }

                return const CircularProgressIndicator();
              }, 
            )
          ]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Order',
          ),
        ],
        selectedItemColor: Colors.blue,
        currentIndex: 1,
        onTap: ((idx){
          List<String> links = ['/tenant/', '/order/list/'];
          Navigator.pushNamed(context, links[idx]);
        }),
      ),
    );
  }
}