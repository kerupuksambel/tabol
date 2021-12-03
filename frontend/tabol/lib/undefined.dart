import 'package:flutter/material.dart';

class UndefinedView extends StatelessWidget {
  final String name;
  const UndefinedView({Key? key, required this.name}) : super(key: key);  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 24), child: Text('Halaman tidak ditemukan')),
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              child: Text('Kembali')
            )
          ],
        )
      ),
    );
  }
}