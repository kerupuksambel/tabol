import 'package:flutter/material.dart';
import 'package:tabol/routes.dart' as routes;
import 'package:tabol/customer/login.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	// This widget is the root of your application.
  
  final bool isLogged = false;

  @override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Tabol',
			theme: ThemeData(
				primarySwatch: Colors.blue
			),
			home: Login(),
      onGenerateRoute: routes.generateRoute,
		);
	}
}