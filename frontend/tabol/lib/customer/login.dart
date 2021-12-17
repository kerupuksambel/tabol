import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);  
  
  @override
	LoginState createState() => LoginState();
}

Future<bool> login(SharedPreferences sharedPreferences, String email, String password) async{
  final response = await http.post(Uri.parse('http://localhost:8000/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "email" : email,
      "password" : password
    })
  );
  print(response.body);
  if (response.statusCode == 200) { 
    bool status = jsonDecode(response.body)["success"];
    if(status){
      int id = jsonDecode(response.body)["id"];  
      sharedPreferences.setInt("id", id);
      return true;
    }else{
      return false;
    }
  } else {
    return false;
  }
} 

class LoginState extends State<Login>{

  late Future<int> status;

  void initState(){
    super.initState();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
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
            Container(
              child: Text("Selamat datang di TABOL", style: TextStyle(fontWeight: FontWeight.bold)),
              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            ),
            Text("Login"),
            Container(
              width: 200,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.text,
              ),
            ),
            Text("Password"),
            Container(
              width: 200,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: TextField(
                controller: passwordController,
                obscureText: true,
              ),
            ),
            ElevatedButton(
              onPressed: (() async {
                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                login(sharedPreferences, emailController.text, passwordController.text).then((res){
                  if(res){
                    sharedPreferences.setBool("isLogged", res);
                    Navigator.pushReplacementNamed(context, "/tenant/");
                  }else{
                    Fluttertoast.showToast(msg: "Username / Password Anda salah.", timeInSecForIosWeb: 3);
                  }
                });
              }), 
              child: Text("Login")
            )
          ]
        )
      ),
    );
  }
}