import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
        body: Stack(children: [
            Image.network(
                "https://drive.google.com/uc?export=view&id=11ShDGY5AU60WrOOFwUnLoejKPio-URHb",
                  fit: BoxFit.fitWidth,
                  height: 250.0,
            ),
            Center(
              child: Container(
                height: 250.0,
                width:300.0,
                color: Colors.black,
                
              ),
            )
        ]),
      )));
}
