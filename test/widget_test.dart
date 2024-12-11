import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: Text("Network Image Example")),
        body: Center(
          child: Image.network(
            "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg", 
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(child: Text('Failed to load image'));
            },
          ),
        ),
      ),
    );
  }
}
