import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabol/model/order.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

 Future<Order> fetchOrder(int id) async{
    final response = await http.get(Uri.parse('http://localhost:8000/api/order/' + id.toString()));
    Order result;
    print(response.body);
    if (response.statusCode == 200) {
      result = Order.fromJson(jsonDecode(response.body));
      return result;
    } else {
      throw Exception('Failed to load tenant');
    }
  } 

class OrderDetail extends StatefulWidget {

  final Order order;
  const OrderDetail({Key? key, required this.order}) : super(key: key);  

  @override
	OrderDetailState createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetail>{

  late Future<Order> futureOrder;

  void initState(){
    super.initState();
    futureOrder = fetchOrder(widget.order.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				title: Text("Detail Order"),
			),
      body: Align(
        alignment: Alignment.topLeft,
        child: FutureBuilder<Order>(
          future: futureOrder,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return Container(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: FlutterMap(
                        options: new MapOptions(
                          center: new LatLng(widget.order.lat, widget.order.long),
                          zoom: 13.0
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate: "http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c']
                          ),
                          MarkerLayerOptions(
                            markers: [
                              new Marker(
                                point: new LatLng(snapshot.data!.lat, snapshot.data!.long),
                                builder: (ctx) =>
                                new Container(
                                  child: Icon(Icons.circle, color: Colors.red,)
                                ),
                              )
                            ]
                          )
                        ],
                      )
                    ),
                    Text('${snapshot.data!.tenantName}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    Text('${snapshot.data!.serviceName}'),
                    Text('${snapshot.data!.hargaFormat}', style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                )
              );
            }

            return const CircularProgressIndicator();
          }, 
        )
      ),
      floatingActionButton: FloatingActionButton(
				onPressed: (){
          Navigator.pushNamed(context, '/order/finish/', arguments: widget.order);
        },
				tooltip: 'Selesaikan',
				child: Icon(Icons.check),
			), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}