import 'package:flutter/material.dart';
import 'package:kytestore/constants/configuraciones.dart';
import 'package:kytestore/rutas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store',
      debugShowCheckedModeBanner: false,
      initialRoute: 'loginView',
      routes: getRutas(),
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color(ConstConfiguraciones.colorKyte),
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
