import 'package:flutter/material.dart';

void main() {
  runApp(     
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            'Hello World!',
            style: TextStyle(
              color: Colors.deepPurple, 
              fontSize: 50, 
              fontWeight: FontWeight.bold,
              letterSpacing: 5 
            ),
          ),
        ),
      ),
    ),
  );  
}