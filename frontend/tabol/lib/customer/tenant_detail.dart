import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabol/model/tenant.dart';
import 'package:http/http.dart' as http;

 Future<Tenant> fetchTenant(int id) async{
    final response = await http.get(Uri.parse('http://localhost:8000/api/tenant/detail/' + id.toString()));
    Tenant result;
    print(response.body);
    if (response.statusCode == 200) {
      result = Tenant.fromJson(jsonDecode(response.body));
      return result;
    } else {
      throw Exception('Failed to load tenant');
    }
  } 

class TenantDetail extends StatefulWidget {

  final int id;
  const TenantDetail({Key? key, required this.id}) : super(key: key);  

  @override
	TenantDetailState createState() => TenantDetailState();
}

class TenantDetailState extends State<TenantDetail>{

  late Future<Tenant> futureTenant;

  void initState(){
    super.initState();
    futureTenant = fetchTenant(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
				title: Text(widget.id.toString()),
			),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<Tenant>(
              future: futureTenant,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Image.network('${snapshot.data!.photoUrl}', fit: BoxFit.cover, width: MediaQuery.of(context).size.width, height: 200,),
                        Padding(
                          padding: EdgeInsets.all(8), 
                          child: Text('${snapshot.data!.nama}', textAlign: TextAlign.left, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 8), 
                          child: Text('${snapshot.data!.deskripsi}', textAlign: TextAlign.left,)
                        ),
                        // Image.network('https://via.placeholder.com/'+ MediaQuery.of(context).size.width.toString() +'x200.png'),
                      ],
                    )
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
          Navigator.pushNamed(context, '/tenant/service', arguments: widget.id);
        },
				tooltip: 'Pesan',
				child: Icon(Icons.shopping_cart),
			), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}