import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello Rectangle',
      home: Scaffold(
        appBar: AppBar(title: Text('Hello Rectangle')),
        body: HelloRectangle(),
      ),
    ),
  );
}

class HelloRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          color: Colors.greenAccent,
          width: 300.0,
          height: 400.0,
          child: Center(
            child: Text(
              'Hello!',
              style: const TextStyle(fontSize: 40.0),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
