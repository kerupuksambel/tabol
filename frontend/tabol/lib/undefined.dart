import 'package:flutter/material.dart';

class UndefinedView extends StatelessWidget {
  final String err;
  const UndefinedView({Key? key, required this.err}) : super(key: key);  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 24), child: Text(this.err)),
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