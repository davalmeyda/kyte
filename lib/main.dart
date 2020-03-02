import 'package:flutter/material.dart';
import 'package:multi_store/rutas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store',
      debugShowCheckedModeBanner: false,
      initialRoute: 'venderView',
      routes: getRutas(),
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(0xff2dd1ac),
        textTheme: TextTheme(
          title: TextStyle(
            color: Colors.black54,
          ),
          subtitle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
